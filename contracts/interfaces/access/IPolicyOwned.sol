// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title Provides backward compatability for Ownership validation from {Ownable} and allows the {SolcurityPolicy} to control the ownership
/// @author tempest-sol <tempest@solcure.io>
interface IPolicyOwned {
    /// @notice Returns the owner address of this contract
    /// @dev The owner should be the {SolcurityPolicy} when trying to enforce policy modules
    /// @return address The owner address
    function owner() external view returns (address);
}