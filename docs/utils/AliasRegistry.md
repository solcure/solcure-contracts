# Solidity API

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

