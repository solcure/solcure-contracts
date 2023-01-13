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

