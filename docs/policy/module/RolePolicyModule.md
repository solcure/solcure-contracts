# Solidity API

## RolePolicyModule

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### EMPTY_ROLE

```solidity
bytes32 EMPTY_ROLE
```

Storage   ///

### FuncSigRoleDef

```solidity
struct FuncSigRoleDef {
  bool hasRoles;
  struct BitMaps.BitMap settings;
  uint8 len;
  mapping(uint8 => uint8) roles;
}
```

### RolePolicyDef

```solidity
struct RolePolicyDef {
  struct EnumerableSet.Bytes32Set roles;
  mapping(address => struct BitMaps.BitMap) consumerRoles;
  mapping(bytes16 => struct EnumerableSet.AddressSet) roleSubscribers;
  mapping(bytes16 => uint8) roleIndexMappings;
  mapping(address => mapping(bytes4 => struct RolePolicyModule.FuncSigRoleDef)) funcSigRoles;
}
```

### FuncSigAccessorAdded

```solidity
event FuncSigAccessorAdded(address policy, address implementation, bytes4 funcSig, address who)
```

Events   ///

### FuncSigAccessorsAdded

```solidity
event FuncSigAccessorsAdded(address policy, address implementation, bytes4 funcSig, address[] who)
```

### PolicyRoleCreated

```solidity
event PolicyRoleCreated(address policy, bytes16 role)
```

### PolicyRolesCreated

```solidity
event PolicyRolesCreated(address policy, bytes16[] roles)
```

### FuncSigRoleSet

```solidity
event FuncSigRoleSet(address policy, address implementation, bytes4 funcSig, bytes16 role)
```

### FuncSigRolesSet

```solidity
event FuncSigRolesSet(address policy, address implementation, bytes4 funcSig, bytes16[] roles)
```

### RoleAccessorAdded

```solidity
event RoleAccessorAdded(address policy, bytes16 role, address who)
```

### RoleAccessorsAdded

```solidity
event RoleAccessorsAdded(address policy, bytes16 role, address[] who)
```

### InvalidFunctionAccess

```solidity
error InvalidFunctionAccess(address policy, address controller, bytes4 funcSig, address who)
```

Errors   ///

### RoleAlreadyExists

```solidity
error RoleAlreadyExists(bytes16 role)
```

### MissingRole

```solidity
error MissingRole(bytes16 role)
```

### AlreadyAssignedRole

```solidity
error AlreadyAssignedRole(bytes16 role, address who)
```

### InvalidRole

```solidity
error InvalidRole()
```

### InvalidParamLength

```solidity
error InvalidParamLength()
```

### EnforcementRoleOrRolesMissing

```solidity
error EnforcementRoleOrRolesMissing()
```

### registeredControllers

```solidity
function registeredControllers(contract ISolcurityPolicy policy) external view returns (address[])
```

Returns the addresses of all controllers that enforce this policy

_Do not use this function in contract logic as the gas consumption is significant_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The {SolcurityPolicy} |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | address An array of addresses |

### createPolicyRole

```solidity
function createPolicyRole(contract ISolcurityPolicy policy, bytes16 role) external
```

Creates a single role for the {SolcurityPolicy} to enforce

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The {SolcurityPolicy} |
| role | bytes16 | The 16 char length role alias |

### createPolicyRoles

```solidity
function createPolicyRoles(contract ISolcurityPolicy policy, bytes16[] roles) external
```

Creates multiple roles for the {SolcurityPolicy} to enforce

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The {SolcurityPolicy} |
| roles | bytes16[] | An array of 16 char length separated role aliases |

### subscribeFuncSigRole

```solidity
function subscribeFuncSigRole(contract ISolcurityPolicy policy, address implementation, bytes4 funcSig, bytes16 role, bool createMissing) external
```

Sets a function to require a role

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The {SolcurityPolicy} |
| implementation | address | The address of the controller |
| funcSig | bytes4 | The function signature |
| role | bytes16 | The 16 char length role alias |
| createMissing | bool | If true, the role will be created if it does not exist |

### subscribeFuncSigRoles

```solidity
function subscribeFuncSigRoles(contract ISolcurityPolicy policy, address implementation, bytes4 funcSig, bytes16[] roles, bool createMissing) external
```

Sets a function to require multiple roles

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The {SolcurityPolicy} |
| implementation | address | The address of the controller |
| funcSig | bytes4 | The function signature |
| roles | bytes16[] | An array of 16 char length separated role aliases |
| createMissing | bool | If true, the role will be created if it does not exist |

### subscribeRoleAccessor

```solidity
function subscribeRoleAccessor(contract ISolcurityPolicy policy, bytes16 role, address who) external
```

Adds a role to an address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The {SolcurityPolicy} |
| role | bytes16 | The 16 char length role alias |
| who | address | The address to add the role to |

### subscribeRoleAccessors

```solidity
function subscribeRoleAccessors(contract ISolcurityPolicy policy, bytes16 role, address[] who) external
```

Adds a role to many addresses

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The {SolcurityPolicy} |
| role | bytes16 | The 16 char length role alias |
| who | address[] | An array of addresses to add the role to |

### _hasRoles

```solidity
function _hasRoles(struct RolePolicyModule.FuncSigRoleDef funcSigDefPtr, struct BitMaps.BitMap consumerRolePtr) internal view returns (bool)
```

Validates that the caller has the required roles to call a function

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| funcSigDefPtr | struct RolePolicyModule.FuncSigRoleDef | The function signature role definition |
| consumerRolePtr | struct BitMaps.BitMap | The consumer role definition {BitMaps.BitMap} |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | bool Returns true if the caller has the required roles |

### enforcePolicy

```solidity
function enforcePolicy(address policy, address controller, bytes4 funcSig, address sender) external view
```

Enforces a security policy on the function being called

_Registration of the controller function must be done on the {SolcurityPolicy} as well as the {PolicyModule} being enforced_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | address | The {SolcurityPolicy} that owners the {controller} |
| controller | address | The controller, typically the caller of this method |
| funcSig | bytes4 | The funcSig derived from {msg.sig} |
| sender | address | The initial {msg.sender} of the function call |

