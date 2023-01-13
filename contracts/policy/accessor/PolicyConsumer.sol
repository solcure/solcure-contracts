// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

import {PolicyOwned} from "../../access/PolicyOwned.sol";
import {ISolcurityPolicy} from "../../interfaces/policy/ISolcurityPolicy.sol";

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title An alternative implementation of PolicyOwned that enforces policy on function calls
/// @author tempest-sol <tempest@solcure.io>
abstract contract PolicyConsumer {
      ///////////////////
     ///   Storage   ///
    ///////////////////
    ISolcurityPolicy private _policy;
      ///////////////////////
     ///   Constructor   /// 
    ///////////////////////
    constructor(ISolcurityPolicy policy) {
        _policy = policy;
    }

    /// @notice Enforces the policy on the function call
    /// @dev This modifier should be applied to all functions that require policy enforcement
    modifier enforcePolicy() {
        _policy.enforcePolicy(msg.sender, msg.sig);
        _;
    }
}