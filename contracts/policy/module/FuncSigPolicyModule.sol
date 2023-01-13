// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

import {ISolcurityPolicy, IPolicyModule, PolicyModule} from "../module/PolicyModule.sol";

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title FuncSigPolicyModule, a policy module that allows for function signature based access control
/// @author tempest-sol <tempest@solcure.io>
contract FuncSigPolicyModule is PolicyModule {
    using EnumerableSet for EnumerableSet.AddressSet;
    using EnumerableSet for EnumerableSet.Bytes32Set;
      ///////////////////
     ///   Storage   ///
    ///////////////////
    mapping(address => EnumerableSet.AddressSet) private _policyControllers;
    mapping(address => mapping(address => EnumerableSet.Bytes32Set)) private _policyControllerFuncSigs;
    mapping(address => mapping(address => mapping(bytes4 => EnumerableSet.AddressSet))) private _policyControllerFuncSigAccessors;
      //////////////////
     ///   Events   ///
    //////////////////
    event FuncSigAccessorAdded(address indexed policy, address indexed implementation, bytes4 indexed funcSig, address who);
    event FuncSigAccessorsAdded(address indexed policy, address indexed implementation, bytes4 indexed funcSig, address[] who);
      //////////////////
     ///   Errors   ///
    //////////////////
    error InvalidFunctionAccess(address policy, address controller, bytes4 funcSig, address who);
    error AccessorAlreadyPermitted();

    /// @notice Returns the registered controllers for a policy
    /// @dev Do not use this function in contract logic as the gas consumption is significant
    /// @param policy The policy to query
    /// @return The registered controllers
    function registeredControllers(address policy) external view returns (address[] memory) {
        return _policyControllers[policy].values();
    }

    /// @notice Returns the registered function signatures for a controller
    /// @dev Do not use this function in contract logic as the gas consumption is significant
    /// @param policy The policy to query
    /// @param controller The controller to query
    /// @return The registered function signatures
    function registeredControllerFuncSigs(address policy, address controller) external view returns (bytes4[] memory) {
        EnumerableSet.Bytes32Set storage ptr = _policyControllerFuncSigs[policy][controller];
        uint len = ptr.length();
        bytes4[] memory funcSigs = new bytes4[](len);
        for(uint i;i<len;) {
            funcSigs[i] = bytes4(ptr.at(i));
            unchecked { ++i; }
        }
        return funcSigs;
    }

    /// @notice Returns the registered function signature accessor addresses for a controller signature
    /// @param policy The policy to query
    /// @param controller The controller to query
    /// @param funcSig The function signature to query
    /// @return The registered function signature accessor addresses
    function registeredControllerFuncSigAccessors(address policy, address controller, bytes4 funcSig) external view returns (address[] memory) {
        return _policyControllerFuncSigAccessors[policy][controller][funcSig].values();
    }

    /// @notice Subscribes an accessor to a function signature of a controller
    /// @param policy The policy to subscribe to
    /// @param implementation The controller to subscribe to
    /// @param funcSig The function signature to subscribe to
    /// @param who The accessor to subscribe
    /// @custom:modifier onlyPolicyAccessor The accessor must be registered as a policy accessor
    /// @custom:modifier policyOwnedImplementation The controller must be registered to the policy
    /// @custom:emit FuncSigAccessorAdded
    /// @custom:revert AccessorAlreadyPermitted
    function subscribeFuncSigAccessor(
        ISolcurityPolicy policy, 
        address implementation, 
        bytes4 funcSig, 
        address who
    ) external onlyPolicyAccessor(policy) policyOwnedImplementation(policy, implementation) {
        _policyControllerFuncSigs[address(policy)][implementation].add(funcSig);
        if(!_policyControllerFuncSigAccessors[address(policy)][implementation][funcSig].add(who))
            revert AccessorAlreadyPermitted();
        emit FuncSigAccessorAdded(address(policy), implementation, funcSig, who);
    }

    /// @notice Subscribes multiple accessors to a function signature of a controller
    /// @param policy The policy to subscribe to
    /// @param implementation The controller to subscribe to
    /// @param funcSig The function signature to subscribe to
    /// @param who The accessors to subscribe
    /// @custom:modifier onlyPolicyAccessor The accessor must be registered as a policy accessor
    /// @custom:modifier policyOwnedImplementation The controller must be registered to the policy
    /// @custom:emit FuncSigAccessorsAdded
    /// @custom:revert AccessorAlreadyPermitted
    function subscribeFuncSigAccessors(
        ISolcurityPolicy policy, 
        address implementation, 
        bytes4 funcSig, 
        address[] calldata who
    ) external onlyPolicyAccessor(policy) policyOwnedImplementation(policy, implementation) {
        uint len = who.length;
        for(uint i;i<len;) {
            _policyControllerFuncSigs[address(policy)][implementation].add(funcSig);
            if(!_policyControllerFuncSigAccessors[address(policy)][implementation][funcSig].add(who[i])) 
                revert AccessorAlreadyPermitted();
            unchecked { ++i; }
        }
        emit FuncSigAccessorsAdded(address(policy), implementation, funcSig, who);
    }

    /// @inheritdoc IPolicyModule
    /// @custom:revert InvalidFunctionAccess The accessor is not registered to the function signature
    function enforcePolicy(address policy, address controller, bytes4 funcSig, address sender) external override view {
        if(!_policyControllerFuncSigs[policy][controller].contains(funcSig)) return;
        if(!_policyControllerFuncSigAccessors[policy][controller][funcSig].contains(sender)) revert InvalidFunctionAccess(
            policy,
            controller,
            funcSig,
            sender
        );
    }
}