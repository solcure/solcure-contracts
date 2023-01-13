# Solidity API

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

