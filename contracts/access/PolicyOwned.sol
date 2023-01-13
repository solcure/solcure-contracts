// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ISolcurityPolicy} from "../interfaces/policy/ISolcurityPolicy.sol";
import {IPolicyOwned} from "../interfaces/access/IPolicyOwned.sol";

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title PolicyOwned, {Ownable} implementation to ensure the {SolcurityPolicy} is the owner of the contract
/// @author tempest-sol <tempest@solcure.io>
contract PolicyOwned is IPolicyOwned, Ownable {
      ///////////////////
     ///   Storage   ///
    ///////////////////
    ISolcurityPolicy private _policy;
      ///////////////////////
     ///   Constructor   /// 
    /////////////////////// 
    constructor(ISolcurityPolicy policy_) Ownable() {
        _transferOwnership(address(policy_));
        _policy = policy_;
    }

    /// @inheritdoc IPolicyOwned
    function owner() public view override(IPolicyOwned, Ownable) returns (address) {
        return super.owner();
    }

    /// @notice Returns the current policy
    /// @return The address of the current policy
    function policy() public view returns (ISolcurityPolicy) {
        return _policy;
    }

    /// @notice Marks the function to check for a policy to enforce
    /// @dev Ensure that the function policy is registered in the {SolcurityPolicy}
    /// @dev The calling function will revert if an error occurs in one of the policy checks
    modifier enforcePolicy() {
        _policy.enforcePolicy(msg.sender, msg.sig);
        _;
    }

    /// @notice Validates that the caller is the {SolcurityPolicy}
    modifier onlyPolicy() {
        if(address(_policy) != msg.sender) revert ();
        _;
    }

    /// @notice Validates that the caller is the {SolcurityPolicy}, delegatee, or a manager
    modifier policyController() {
        if(!(msg.sender == address(_policy) || _policy.isManager(msg.sender))) revert ();
        _;
    }
}