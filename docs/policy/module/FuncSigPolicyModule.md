# Solidity API

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

