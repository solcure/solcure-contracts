# Solidity API

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

