// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title An implementation to manage and control security enforcement from multiple contracts and their functions
/// @author tempest-sol <tempest@solcure.io>
interface ISolcurityPolicy {
      ///////////////////
     ///   Events    ///
    ///////////////////
    event ModuleSubscribed(address indexed implementation);
    event ControllerSubscribed(address indexed controller);
    event ManagerAdded(address indexed manager);
    event ManagerRemoved(address indexed manager);
      ///////////////////
     ///   Errors    ///
    ///////////////////
    error ModuleAlreadySubscribed(address module);
    error ControllerAlreadySubscribed(address controller);
    error PolicyNotOwner(address implementation);
    error UnknownRevertReason();
    error AddressNotContract(address addr);
    error CallerNotController(address caller);
    error AlreadyManager(address manager);
    error NotValidManager(address manager);
    /// @notice Determines if the caller is a manager of the {SolcurityPolicy}
    /// @param who The address to check
    function isManager(address who) external view returns (bool);
    /// @notice The delegate owner of this policy
    /// @return address The owner address
    function delagetee() external view returns (address);
    /// @notice Function for controller contracts to validate policy enforcement
    /// @param caller The caller of the initial execution
    /// @param funcSig The function signature
    function enforcePolicy(address caller, bytes4 funcSig) external view;
}