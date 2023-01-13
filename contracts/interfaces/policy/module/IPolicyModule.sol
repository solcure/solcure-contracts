// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title An implementation to allow enforcement of secure standards on an individual function
/// @author tempest-sol <tempest@solcure.io>
interface IPolicyModule {
      ////////////////////
     ///    Errors    ///
    ////////////////////
    error NotPolicyOwned(address implementation);
    error NotPolicyAccessor();
    error UnknownRevert();
    /// @notice Enforces a security policy on the function being called
    /// @dev Registration of the controller function must be done on the {SolcurityPolicy} as well as the {PolicyModule} being enforced
    /// @param policy The {SolcurityPolicy} that owners the {controller}
    /// @param controller The controller, typically the caller of this method
    /// @param funcSig The funcSig derived from {msg.sig}
    /// @param sender The initial {msg.sender} of the function call
    function enforcePolicy(address policy, address controller, bytes4 funcSig, address sender) external view;
}