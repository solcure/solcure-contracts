# Solidity API

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

