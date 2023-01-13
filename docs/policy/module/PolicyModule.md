# Solidity API

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

