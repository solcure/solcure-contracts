// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title AliasRegistry, a registry for contract implementations and their aliases for easy lookup
/// @author tempest-sol <tempest@solcure.io>
interface IAliasRegistry {
      //////////////////
     ///   Events   ///
    //////////////////
    event AliasRegistered(address indexed implementation, bytes16 indexed _alias);
    event AliasRemoved(address indexed implementation, bytes16 indexed _alias);
      //////////////////
     ///   Errors   ///
    //////////////////
    error AliasAlreadyRegistered(bytes16 _alias);
    error AliasNotRegistered(bytes16 _alias);
    /// @notice Gets the alias for an implementation
    /// @param implementation The implementation address
    /// @return The alias for the implementation
    function getAlias(address implementation) external view returns (bytes16);
    /// @notice Gets the implementation for an alias
    /// @param _alias The alias
    /// @return The implementation address
    function getImplementation(bytes16 _alias) external view returns (address);
}