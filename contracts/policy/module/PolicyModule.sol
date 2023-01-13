// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {EnumerableSetUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/structs/EnumerableSetUpgradeable.sol";

import {IPolicyModule} from "../../interfaces/policy/module/IPolicyModule.sol";
import {ISolcurityPolicy} from "../../interfaces/policy/ISolcurityPolicy.sol";

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title An implementation to allow enforcement of secure standards on an individual function
/// @author tempest-sol <tempest@solcure.io>
abstract contract PolicyModule is IPolicyModule {
    /// @notice Validates that the implementation contract is owned by the {SolcurityPolicy}
    /// @param policy The {SolcurityPolicy}
    /// @param implementation The implementation address
    /// @custom:reverts [NotPolicyOwned, UnknownRevert]
    modifier policyOwnedImplementation(ISolcurityPolicy policy, address implementation) {
        try Ownable(implementation).owner() returns (address owner) {
            if (address(policy) != owner) {
                revert NotPolicyOwned(implementation);
            }
        } catch (bytes memory reason) {
            if (reason.length == 0) {
                revert UnknownRevert();
            } else {
                assembly {
                    revert(add(32, reason), mload(reason))
                }
            }
        }
        _;
    }
    /// @notice Validates that only a {SolcurityPolicy} manager, delegate owner, or itself is the caller
    /// @param policy The {SolcurityPolicy}
    /// @custom:revert NotPolicyAccessor
    modifier onlyPolicyAccessor(ISolcurityPolicy policy) {
        if(!(msg.sender == address(policy) || msg.sender == policy.delagetee() || policy.isManager(msg.sender))) revert NotPolicyAccessor();
        _;
    }
}