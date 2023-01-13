// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

import {ISolcurityPolicy} from "../interfaces/policy/ISolcurityPolicy.sol";
import {IPolicyModule} from "../interfaces/policy/module/IPolicyModule.sol";
import {IPolicyOwned} from "../interfaces/access/IPolicyOwned.sol";

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title Solcurity Policy Contract
/// @author tempest-sol <tempest@solcure.io>
contract SolcurityPolicy is ISolcurityPolicy, Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;
      ///////////////////
     ///   Storage   ///
    ///////////////////
    address private _delegatee; // the delegate owner, managed by this policy

    EnumerableSet.AddressSet private _subscribedModules;
    EnumerableSet.AddressSet private _subscribedControllers;
    EnumerableSet.AddressSet private _managers;

    mapping(address => EnumerableSet.Bytes32Set) private _controllersFuncSigs;
    mapping(address => mapping(bytes4 => bytes4)) private _controllerFuncSigMappings;
    mapping(address => mapping(bytes4 => IPolicyModule)) private _controllerFuncSigModuleMappings;
      ///////////////////////
     ///   Constructor   /// 
    ///////////////////////
    constructor() Ownable() { 
        _delegatee = msg.sender;
    }

    /// @notice Subscribes a security module to the policy
    /// @param implementation The address of the {IPolicyModule} implementation
    /// @custom:modifier validModule Checks that the implementation is a valid module
    /// @custom:revert ModuleAlreadySubscribed
    /// @custom:emit ModuleSubscribed
    function subscribeModule(address implementation) external validModule(implementation) {
        if(!_subscribedModules.add(implementation)) revert ModuleAlreadySubscribed(implementation);
        emit ModuleSubscribed(implementation);
    }

    /// @notice Subscribes multiple security modules to the policy
    /// @param implementations The addresses of the {IPolicyModule} implementations
    /// @custom:revert ModuleAlreadySubscribed
    /// @custom:emit ModuleSubscribed
    function subscribeModules(address[] calldata implementations) external {
        uint len = implementations.length;
        for(uint i;i<len;) {
            _validateModule(implementations[i]);
            if(!_subscribedModules.add(implementations[i])) revert ModuleAlreadySubscribed(implementations[i]);
            emit ModuleSubscribed(implementations[i]);
            unchecked { ++i; }
        }
    }

    /// @notice Subscribes a controller to the policy
    /// @dev There is no validation against the controllers authenticity, this is left to the controller and implementor
    /// @param implementation The address of the controller implementation
    /// @custom:revet ControllerAlreadySubscribed
    /// @custom:emit ControllerSubscribed
    function subscribeController(address implementation) external {
        if(!_subscribedControllers.add(implementation)) revert ControllerAlreadySubscribed(implementation);
        emit ControllerSubscribed(implementation);
    }

    /// @notice Subscribes a function of a controller contract to a policy module
    /// @dev Sets the {IPolicyModule} implementation to be used for the given function signature
    /// @param controller The address of the controller implementation
    /// @param funcSig The function signature of the controller function
    /// @param module The address of the {IPolicyModule} implementation
    function subscribeFunctionPolicy(address controller, bytes4 funcSig, IPolicyModule module) external onlyOwner onlySubscribedController(controller) {
        _controllerFuncSigModuleMappings[controller][funcSig] = module;
    }

    /// @notice Registers an address as a manager of this policy
    /// @dev Only the owner of this contract can register a manager
    /// @param who The address to register as a manager
    /// @custom:modifier onlyOwner Checks that the caller is the owner of this contract
    /// @custom:emit ManagerAdded
    function registerPolicyManager(address who) external onlyOwner {
        if(!_managers.add(who)) revert AlreadyManager(who);
        emit ManagerAdded(who);
    }

    /// @notice Removes an address as a manager of this policy
    /// @dev Only the owner of this contract can remove a manager
    /// @param who The address to remove as a manager
    /// @custom:modifier onlyOwner Checks that the caller is the owner of this contract
    /// @custom:emit ManagerRemoved
    /// @custom:revert NotValidManager
    function removePolicyManager(address who) external onlyOwner {
        if(!_managers.remove(who)) revert NotValidManager(who);
        emit ManagerRemoved(who);
    }

    /// @inheritdoc ISolcurityPolicy
    /// @custom:modifier subscribedController Checks that the controller is subscribed to this policy
    function enforcePolicy(address caller, bytes4 funcSig) external subscribedController view {
        IPolicyModule implementation = _controllerFuncSigModuleMappings[msg.sender][funcSig];
        if(address(implementation) == address(0x0)) return;
        implementation.enforcePolicy(address(this), msg.sender, funcSig, caller);
    }

    /// @inheritdoc ISolcurityPolicy
    function isManager(address who) external override view returns (bool) {
        return _managers.contains(who);
    }

    /// @inheritdoc ISolcurityPolicy
    function delagetee() external override view returns (address) {
        return _delegatee;
    }

    /// @notice Transfers ownership of the implementation to the delegatee
    /// @dev This removes the implementation from the subscribed modules and controllers
    /// @param policyOwnedImpl The address of the implementation to transfer ownership of
    /// @custom:modifier onlyOwner Checks that the caller is the owner of this contract
    function transferOwnershipOf(address policyOwnedImpl) external onlyOwner {
        _validateOwner(policyOwnedImpl);
        Ownable(policyOwnedImpl).transferOwnership(_delegatee);
        _subscribedModules.remove(policyOwnedImpl);
        _subscribedControllers.remove(policyOwnedImpl);
    }

    /// @notice Validates that the given address's owner is this policy
    /// @param implementation The address to validate ownership of
    /// @custom:reverts [PolicyNotOwner, UnknownRevertReason]
    function _validateOwner(address implementation) internal view {
        try Ownable(implementation).owner() returns (address owner) {
            if (address(this) != owner) {
                revert PolicyNotOwner(implementation);
            }
        } catch (bytes memory reason) {
            if (reason.length == 0) {
                revert UnknownRevertReason();
            } else {
                assembly {
                    revert(add(32, reason), mload(reason))
                }
            }
        }
    }

    /// @notice Ensures that the given address is a valid module
    /// @custom:revert AddressNotContract
    function _validateModule(address implementation) internal view {
        if(implementation.code.length == 0) revert AddressNotContract(implementation);
        _validateOwner(implementation);
    }

    /// @notice Validates that the given address is a valid module
    modifier validModule(address implementation) {
        _validateModule(implementation);
        _;
    }

    /// @notice Checks that the caller is subscribed to this policy
    /// @dev This implies that the caller is a controller, skips storage comparison as it won't exist if it isn't a subscribed controller
    /// @custom:revert CallerNotController
    modifier subscribedController() {
        if(!_subscribedControllers.contains(msg.sender)) revert CallerNotController(msg.sender);
        _;
    }

    /// @notice Checks that the given address is a subscribed controller
    /// @param controller The address to check
    /// @custom:revert CallerNotController
    modifier onlySubscribedController(address controller) {
        if(!_subscribedControllers.contains(controller)) revert CallerNotController(controller);
        _;
    }
}