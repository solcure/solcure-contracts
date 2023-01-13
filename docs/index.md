# Solidity API

## PolicyOwned

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### constructor

```solidity
constructor(contract ISolcurityPolicy policy_) public
```

Constructor   ///

### owner

```solidity
function owner() public view returns (address)
```

Returns the owner address of this contract

_The owner should be the {SolcurityPolicy} when trying to enforce policy modules_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | address The owner address |

### policy

```solidity
function policy() public view returns (contract ISolcurityPolicy)
```

Returns the current policy

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | contract ISolcurityPolicy | The address of the current policy |

### enforcePolicy

```solidity
modifier enforcePolicy()
```

Marks the function to check for a policy to enforce

_Ensure that the function policy is registered in the {SolcurityPolicy}
The calling function will revert if an error occurs in one of the policy checks_

### onlyPolicy

```solidity
modifier onlyPolicy()
```

Validates that the caller is the {SolcurityPolicy}

### policyController

```solidity
modifier policyController()
```

Validates that the caller is the {SolcurityPolicy}, delegatee, or a manager

## IPolicyOwned

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### owner

```solidity
function owner() external view returns (address)
```

Returns the owner address of this contract

_The owner should be the {SolcurityPolicy} when trying to enforce policy modules_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | address The owner address |

## ISolcurityPolicy

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### ModuleSubscribed

```solidity
event ModuleSubscribed(address implementation)
```

Events    ///

### ControllerSubscribed

```solidity
event ControllerSubscribed(address controller)
```

### ManagerAdded

```solidity
event ManagerAdded(address manager)
```

### ManagerRemoved

```solidity
event ManagerRemoved(address manager)
```

### ModuleAlreadySubscribed

```solidity
error ModuleAlreadySubscribed(address module)
```

Errors    ///

### ControllerAlreadySubscribed

```solidity
error ControllerAlreadySubscribed(address controller)
```

### PolicyNotOwner

```solidity
error PolicyNotOwner(address implementation)
```

### UnknownRevertReason

```solidity
error UnknownRevertReason()
```

### AddressNotContract

```solidity
error AddressNotContract(address addr)
```

### CallerNotController

```solidity
error CallerNotController(address caller)
```

### AlreadyManager

```solidity
error AlreadyManager(address manager)
```

### NotValidManager

```solidity
error NotValidManager(address manager)
```

### isManager

```solidity
function isManager(address who) external view returns (bool)
```

Determines if the caller is a manager of the {SolcurityPolicy}

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| who | address | The address to check |

### delagetee

```solidity
function delagetee() external view returns (address)
```

The delegate owner of this policy

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | address The owner address |

### enforcePolicy

```solidity
function enforcePolicy(address caller, bytes4 funcSig) external view
```

Function for controller contracts to validate policy enforcement

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The caller of the initial execution |
| funcSig | bytes4 | The function signature |

## IPolicyModule

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### NotPolicyOwned

```solidity
error NotPolicyOwned(address implementation)
```

Errors    ///

### NotPolicyAccessor

```solidity
error NotPolicyAccessor()
```

### UnknownRevert

```solidity
error UnknownRevert()
```

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

## IAliasRegistry

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### AliasRegistered

```solidity
event AliasRegistered(address implementation, bytes16 _alias)
```

Events   ///

### AliasRemoved

```solidity
event AliasRemoved(address implementation, bytes16 _alias)
```

### AliasAlreadyRegistered

```solidity
error AliasAlreadyRegistered(bytes16 _alias)
```

Errors   ///

### AliasNotRegistered

```solidity
error AliasNotRegistered(bytes16 _alias)
```

### getAlias

```solidity
function getAlias(address implementation) external view returns (bytes16)
```

Gets the alias for an implementation

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | The implementation address |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes16 | The alias for the implementation |

### getImplementation

```solidity
function getImplementation(bytes16 _alias) external view returns (address)
```

Gets the implementation for an alias

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _alias | bytes16 | The alias |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The implementation address |

## MockController

### constructor

```solidity
constructor(contract ISolcurityPolicy policy) public
```

### exampleFunction

```solidity
function exampleFunction() external
```

## SolcurityPolicy

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### constructor

```solidity
constructor() public
```

Constructor   ///

### subscribeModule

```solidity
function subscribeModule(address implementation) external
```

Subscribes a security module to the policy

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | The address of the {IPolicyModule} implementation |

### subscribeModules

```solidity
function subscribeModules(address[] implementations) external
```

Subscribes multiple security modules to the policy

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementations | address[] | The addresses of the {IPolicyModule} implementations |

### subscribeController

```solidity
function subscribeController(address implementation) external
```

Subscribes a controller to the policy

_There is no validation against the controllers authenticity, this is left to the controller and implementor_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | The address of the controller implementation |

### subscribeFunctionPolicy

```solidity
function subscribeFunctionPolicy(address controller, bytes4 funcSig, contract IPolicyModule module) external
```

Subscribes a function of a controller contract to a policy module

_Sets the {IPolicyModule} implementation to be used for the given function signature_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| controller | address | The address of the controller implementation |
| funcSig | bytes4 | The function signature of the controller function |
| module | contract IPolicyModule | The address of the {IPolicyModule} implementation |

### registerPolicyManager

```solidity
function registerPolicyManager(address who) external
```

Registers an address as a manager of this policy

_Only the owner of this contract can register a manager_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| who | address | The address to register as a manager |

### removePolicyManager

```solidity
function removePolicyManager(address who) external
```

Removes an address as a manager of this policy

_Only the owner of this contract can remove a manager_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| who | address | The address to remove as a manager |

### enforcePolicy

```solidity
function enforcePolicy(address caller, bytes4 funcSig) external view
```

Function for controller contracts to validate policy enforcement

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| caller | address | The caller of the initial execution |
| funcSig | bytes4 | The function signature |

### isManager

```solidity
function isManager(address who) external view returns (bool)
```

Determines if the caller is a manager of the {SolcurityPolicy}

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| who | address | The address to check |

### delagetee

```solidity
function delagetee() external view returns (address)
```

The delegate owner of this policy

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | address The owner address |

### transferOwnershipOf

```solidity
function transferOwnershipOf(address policyOwnedImpl) external
```

Transfers ownership of the implementation to the delegatee

_This removes the implementation from the subscribed modules and controllers_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policyOwnedImpl | address | The address of the implementation to transfer ownership of |

### _validateOwner

```solidity
function _validateOwner(address implementation) internal view
```

Validates that the given address's owner is this policy

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | The address to validate ownership of |

### _validateModule

```solidity
function _validateModule(address implementation) internal view
```

Ensures that the given address is a valid module

### validModule

```solidity
modifier validModule(address implementation)
```

Validates that the given address is a valid module

### subscribedController

```solidity
modifier subscribedController()
```

Checks that the caller is subscribed to this policy

_This implies that the caller is a controller, skips storage comparison as it won't exist if it isn't a subscribed controller_

### onlySubscribedController

```solidity
modifier onlySubscribedController(address controller)
```

Checks that the given address is a subscribed controller

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| controller | address | The address to check |

## PolicyConsumer

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### constructor

```solidity
constructor(contract ISolcurityPolicy policy) internal
```

Constructor   ///

### enforcePolicy

```solidity
modifier enforcePolicy()
```

Enforces the policy on the function call

_This modifier should be applied to all functions that require policy enforcement_

## FuncSigPolicyModule

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### FuncSigAccessorAdded

```solidity
event FuncSigAccessorAdded(address policy, address implementation, bytes4 funcSig, address who)
```

Events   ///

### FuncSigAccessorsAdded

```solidity
event FuncSigAccessorsAdded(address policy, address implementation, bytes4 funcSig, address[] who)
```

### InvalidFunctionAccess

```solidity
error InvalidFunctionAccess(address policy, address controller, bytes4 funcSig, address who)
```

Errors   ///

### AccessorAlreadyPermitted

```solidity
error AccessorAlreadyPermitted()
```

### registeredControllers

```solidity
function registeredControllers(address policy) external view returns (address[])
```

Returns the registered controllers for a policy

_Do not use this function in contract logic as the gas consumption is significant_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | address | The policy to query |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The registered controllers |

### registeredControllerFuncSigs

```solidity
function registeredControllerFuncSigs(address policy, address controller) external view returns (bytes4[])
```

Returns the registered function signatures for a controller

_Do not use this function in contract logic as the gas consumption is significant_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | address | The policy to query |
| controller | address | The controller to query |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes4[] | The registered function signatures |

### registeredControllerFuncSigAccessors

```solidity
function registeredControllerFuncSigAccessors(address policy, address controller, bytes4 funcSig) external view returns (address[])
```

Returns the registered function signature accessor addresses for a controller signature

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | address | The policy to query |
| controller | address | The controller to query |
| funcSig | bytes4 | The function signature to query |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | The registered function signature accessor addresses |

### subscribeFuncSigAccessor

```solidity
function subscribeFuncSigAccessor(contract ISolcurityPolicy policy, address implementation, bytes4 funcSig, address who) external
```

Subscribes an accessor to a function signature of a controller

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The policy to subscribe to |
| implementation | address | The controller to subscribe to |
| funcSig | bytes4 | The function signature to subscribe to |
| who | address | The accessor to subscribe |

### subscribeFuncSigAccessors

```solidity
function subscribeFuncSigAccessors(contract ISolcurityPolicy policy, address implementation, bytes4 funcSig, address[] who) external
```

Subscribes multiple accessors to a function signature of a controller

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The policy to subscribe to |
| implementation | address | The controller to subscribe to |
| funcSig | bytes4 | The function signature to subscribe to |
| who | address[] | The accessors to subscribe |

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

## PolicyModule

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### policyOwnedImplementation

```solidity
modifier policyOwnedImplementation(contract ISolcurityPolicy policy, address implementation)
```

Validates that the implementation contract is owned by the {SolcurityPolicy}

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The {SolcurityPolicy} |
| implementation | address | The implementation address |

### onlyPolicyAccessor

```solidity
modifier onlyPolicyAccessor(contract ISolcurityPolicy policy)
```

Validates that only a {SolcurityPolicy} manager, delegate owner, or itself is the caller

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| policy | contract ISolcurityPolicy | The {SolcurityPolicy} |

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

## AliasRegistry

░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///

### constructor

```solidity
constructor() public
```

Constructor   ///

### registerAlias

```solidity
function registerAlias(address implementation, bytes16 _alias) external
```

Registers an implementation with an alias

_Only the owner can register an alias_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | The implementation address |
| _alias | bytes16 | The alias to register |

### removeAlias

```solidity
function removeAlias(bytes16 _alias) external
```

Removes an alias from the registry

_Only the owner can remove an alias_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _alias | bytes16 | The alias to remove |

### getAlias

```solidity
function getAlias(address implementation) external view returns (bytes16)
```

Gets the alias for an implementation

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| implementation | address | The implementation address |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes16 | The alias for the implementation |

### getImplementation

```solidity
function getImplementation(bytes16 _alias) external view returns (address)
```

Gets the implementation for an alias

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _alias | bytes16 | The alias |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The implementation address |

