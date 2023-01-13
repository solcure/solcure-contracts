// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import {BitMaps} from "@openzeppelin/contracts/utils/structs/BitMaps.sol";

import {IPolicyModule, ISolcurityPolicy, PolicyModule} from "../module/PolicyModule.sol";

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title Enforces a required role or set of roles for access to a function
/// @author tempest-sol <tempest@solcure.io>
contract RolePolicyModule is PolicyModule {
    using BitMaps for BitMaps.BitMap;
    using EnumerableSet for EnumerableSet.AddressSet;
    using EnumerableSet for EnumerableSet.Bytes32Set;
      ///////////////////
     ///   Storage   ///
    ///////////////////
    bytes32 immutable EMPTY_ROLE = bytes32("");
    mapping(ISolcurityPolicy => EnumerableSet.AddressSet) private _policyControllers;
    mapping(ISolcurityPolicy => RolePolicyDef) private _policyRoleDefs;
      ///////////////////
     ///   Structs   ///
    ///////////////////    
    struct FuncSigRoleDef {
        bool hasRoles;
        BitMaps.BitMap settings;
        uint8 len;
        mapping(uint8 => uint8) roles;
    }
    struct RolePolicyDef {
        EnumerableSet.Bytes32Set roles;
        mapping(address => BitMaps.BitMap) consumerRoles;
        mapping(bytes16 => EnumerableSet.AddressSet) roleSubscribers;
        mapping(bytes16 => uint8) roleIndexMappings;
        mapping(address => mapping(bytes4 => FuncSigRoleDef)) funcSigRoles;
    }
      //////////////////
     ///   Events   ///
    //////////////////
    event FuncSigAccessorAdded(address indexed policy, address indexed implementation, bytes4 indexed funcSig, address who);
    event FuncSigAccessorsAdded(address indexed policy, address indexed implementation, bytes4 indexed funcSig, address[] who);
    event PolicyRoleCreated(address indexed policy, bytes16 indexed role);
    event PolicyRolesCreated(address indexed policy, bytes16[] indexed roles);
    event FuncSigRoleSet(address indexed policy, address indexed implementation, bytes4 indexed funcSig, bytes16 role);
    event FuncSigRolesSet(address indexed policy, address indexed implementation, bytes4 indexed funcSig, bytes16[] roles);
    event RoleAccessorAdded(address indexed policy, bytes16 indexed role, address indexed who);
    event RoleAccessorsAdded(address indexed policy, bytes16 indexed role, address[] indexed who);
      //////////////////
     ///   Errors   ///
    //////////////////
    error InvalidFunctionAccess(address policy, address controller, bytes4 funcSig, address who);
    error RoleAlreadyExists(bytes16 role);
    error MissingRole(bytes16 role);
    error AlreadyAssignedRole(bytes16 role, address who);
    error InvalidRole();
    error InvalidParamLength();
    error EnforcementRoleOrRolesMissing();

    /// @notice Returns the addresses of all controllers that enforce this policy
    /// @dev Do not use this function in contract logic as the gas consumption is significant
    /// @param policy The {SolcurityPolicy}
    /// @return address An array of addresses
    function registeredControllers(ISolcurityPolicy policy) external view returns (address[] memory) {
        return _policyControllers[policy].values();
    }

    /// @notice Creates a single role for the {SolcurityPolicy} to enforce
    /// @param policy The {SolcurityPolicy}
    /// @param role The 16 char length role alias
    /// @custom:modifier onlyPolicyAccessor Validates that the caller has {SolcurityPolicy} access
    /// @custom:revert RoleAlreadyExists
    /// @custom:emit PolicyRoleCreated
    function createPolicyRole(ISolcurityPolicy policy, bytes16 role) external onlyPolicyAccessor(policy) {
        RolePolicyDef storage defPtr = _policyRoleDefs[policy];
        EnumerableSet.Bytes32Set storage rolesPtr = defPtr.roles;
        uint8 roleIdx = uint8(rolesPtr.length() + 1);
        if(!rolesPtr.add(role)) revert RoleAlreadyExists(role);
        defPtr.roleIndexMappings[role] = roleIdx;

        emit PolicyRoleCreated(address(policy), role);
    }

    /// @notice Creates multiple roles for the {SolcurityPolicy} to enforce
    /// @param policy The {SolcurityPolicy}
    /// @param roles An array of 16 char length separated role aliases
    /// @custom:modifier onlyPolicyAccessor Validates that the caller has {SolcurityPolicy} access
    /// @custom:reverts [RoleAlreadyExists, InvalidRole]
    /// @custom:emit PolicyRolesCreated
    function createPolicyRoles(ISolcurityPolicy policy, bytes16[] calldata roles) external onlyPolicyAccessor(policy) {
        RolePolicyDef storage defPtr = _policyRoleDefs[policy];
        EnumerableSet.Bytes32Set storage rolesPtr = defPtr.roles;
        uint8 roleIdx = uint8(rolesPtr.length() + 1); //leave 0 as a default reference value
        uint len = roles.length;
        for(uint8 i;i<len;) {
            if(roles[i] == EMPTY_ROLE) revert InvalidRole();
            if(!rolesPtr.add(roles[i])) revert RoleAlreadyExists(roles[i]);
            defPtr.roleIndexMappings[roles[i]] = roleIdx + i;
            unchecked { ++i; }
        }

        emit PolicyRolesCreated(address(policy), roles);
    }

    /// @notice Sets a function to require a role
    /// @param policy The {SolcurityPolicy}
    /// @param implementation The address of the controller
    /// @param funcSig The function signature
    /// @param role The 16 char length role alias
    /// @param createMissing If true, the role will be created if it does not exist
    /// @custom:modifier onlyPolicyAccessor Validates that the caller has {SolcurityPolicy} access
    /// @custom:modifier policyOwnedImplementation Validates that the controller is owned by the {SolcurityPolicy}
    /// @custom:reverts [MissingRole, RoleAlreadyExists]
    /// @custom:emit FuncSigRoleSet
    function subscribeFuncSigRole(
        ISolcurityPolicy policy,
        address implementation, 
        bytes4 funcSig, 
        bytes16 role,
        bool createMissing
    ) external onlyPolicyAccessor(policy) policyOwnedImplementation(policy, implementation) {
        RolePolicyDef storage defPtr = _policyRoleDefs[policy];
        EnumerableSet.Bytes32Set storage rolesPtr = defPtr.roles;
        if(!createMissing && !rolesPtr.contains(role)) revert MissingRole(role);
        else if(!rolesPtr.add(role)) revert RoleAlreadyExists(role);
        _policyControllers[policy].add(implementation);
        uint8 roleIdx = defPtr.roleIndexMappings[role];
        FuncSigRoleDef storage funcSigDefPtr = defPtr.funcSigRoles[implementation][funcSig];
        funcSigDefPtr.hasRoles = true;
        uint8 currLen = funcSigDefPtr.len;
        funcSigDefPtr.roles[currLen] = roleIdx;
        funcSigDefPtr.settings.set(roleIdx);
        
        emit FuncSigRoleSet(address(policy), implementation, funcSig, role);
    }

    /// @notice Sets a function to require multiple roles
    /// @param policy The {SolcurityPolicy}
    /// @param implementation The address of the controller
    /// @param funcSig The function signature
    /// @param roles An array of 16 char length separated role aliases
    /// @param createMissing If true, the role will be created if it does not exist
    /// @custom:modifier onlyPolicyAccessor Validates that the caller has {SolcurityPolicy} access
    /// @custom:modifier policyOwnedImplementation Validates that the controller is owned by the {SolcurityPolicy}
    /// @custom:reverts [InvalidParamLength, MissingRole, RoleAlreadyExists]
    /// @custom:emit FuncSigRolesSet
    function subscribeFuncSigRoles(
        ISolcurityPolicy policy, 
        address implementation, 
        bytes4 funcSig,
        bytes16[] calldata roles,
        bool createMissing
    ) external onlyPolicyAccessor(policy) policyOwnedImplementation(policy, implementation) {
        RolePolicyDef storage defPtr = _policyRoleDefs[policy];
        EnumerableSet.Bytes32Set storage rolesPtr = defPtr.roles;
        uint len = roles.length;
        if(len == 0) revert InvalidParamLength();
        _policyControllers[policy].add(implementation);
        FuncSigRoleDef storage funcSigDefPtr = defPtr.funcSigRoles[implementation][funcSig];
        uint8 currLen = funcSigDefPtr.len;
        for(uint8 i;i<len;) {
            if(!createMissing && !rolesPtr.contains(roles[i])) revert MissingRole(roles[i]);
            else if(!rolesPtr.add(roles[i])) revert RoleAlreadyExists(roles[i]);
            uint8 roleIdx = defPtr.roleIndexMappings[roles[i]];
            if(!funcSigDefPtr.hasRoles) 
                funcSigDefPtr.hasRoles = true;
            funcSigDefPtr.roles[currLen + i] = roleIdx;
            funcSigDefPtr.settings.set(roleIdx);
            unchecked { ++i; }
        }
        
        emit FuncSigRolesSet(address(policy), implementation, funcSig, roles);
    }

    /// @notice Adds a role to an address
    /// @param policy The {SolcurityPolicy}
    /// @param role The 16 char length role alias
    /// @param who The address to add the role to
    /// @custom:modifier onlyPolicyAccessor Validates that the caller has {SolcurityPolicy} access
    /// @custom:reverts [InvalidRole, AlreadyAssignedRole]
    /// @custom:emit RoleAccessorAdded
    function subscribeRoleAccessor(
        ISolcurityPolicy policy, 
        bytes16 role,
        address who
    ) external onlyPolicyAccessor(policy) {
        RolePolicyDef storage defPtr = _policyRoleDefs[policy];
        EnumerableSet.Bytes32Set storage rolesPtr = defPtr.roles;
        if(!rolesPtr.contains(role)) revert InvalidRole();
        if(!defPtr.roleSubscribers[role].add(who)) revert AlreadyAssignedRole(role, who);
        BitMaps.BitMap storage bitMapPtr = defPtr.consumerRoles[who];
        uint8 roleIdx = defPtr.roleIndexMappings[role];
        if(!bitMapPtr.get(roleIdx))
            bitMapPtr.set(roleIdx);

        emit RoleAccessorAdded(address(policy), role, who);
    }

    /// @notice Adds a role to many addresses
    /// @param policy The {SolcurityPolicy}
    /// @param role The 16 char length role alias
    /// @param who An array of addresses to add the role to
    /// @custom:modifier onlyPolicyAccessor Validates that the caller has {SolcurityPolicy} access
    /// @custom:reverts [InvalidRole, AlreadyAssignedRole]
    /// @custom:emit RoleAccessorAdded
    function subscribeRoleAccessors(
        ISolcurityPolicy policy, 
        bytes16 role,
        address[] calldata who
    ) external onlyPolicyAccessor(policy) {
        uint len = who.length;
        RolePolicyDef storage defPtr = _policyRoleDefs[policy];
        EnumerableSet.Bytes32Set storage rolesPtr = defPtr.roles;
        if(!rolesPtr.contains(role)) revert InvalidRole();
        for(uint i;i<len;) {
            if(!defPtr.roleSubscribers[role].add(who[i])) revert AlreadyAssignedRole(role, who[i]);
            BitMaps.BitMap storage bitMapPtr = defPtr.consumerRoles[who[i]];
            uint8 roleIdx = defPtr.roleIndexMappings[role];
            if(!bitMapPtr.get(roleIdx))
                bitMapPtr.set(roleIdx);
            unchecked { ++i; }
        }

        emit RoleAccessorsAdded(address(policy), role, who);
    }

    /// @notice Validates that the caller has the required roles to call a function
    /// @param funcSigDefPtr The function signature role definition
    /// @param consumerRolePtr The consumer role definition {BitMaps.BitMap}
    /// @return bool Returns true if the caller has the required roles
    function _hasRoles(FuncSigRoleDef storage funcSigDefPtr, BitMaps.BitMap storage consumerRolePtr) internal view returns (bool) {
        uint8 len = funcSigDefPtr.len;
        uint8 roleIdx;
        uint256 validRole;
        for(uint8 i;i<len;) {
            roleIdx = funcSigDefPtr.roles[i];
            validRole = consumerRolePtr.get(roleIdx) ? 0 : 1;
            if(validRole == 1) return false;
            unchecked { ++i; }
        }
        return true;
    }

    /// @inheritdoc IPolicyModule
    /// @custom:reverts [EnforcementRoleOrRolesMissing]
    function enforcePolicy(address policy, address controller, bytes4 funcSig, address sender) external override view {
        ISolcurityPolicy _policy = ISolcurityPolicy(policy);
        RolePolicyDef storage defPtr = _policyRoleDefs[_policy];
        FuncSigRoleDef storage funcSigDefPtr = defPtr.funcSigRoles[controller][funcSig];
        if(!funcSigDefPtr.hasRoles) return;
        if(!_hasRoles(funcSigDefPtr, defPtr.consumerRoles[sender])) revert EnforcementRoleOrRolesMissing();
    }
}