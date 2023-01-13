# Solidity API

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

