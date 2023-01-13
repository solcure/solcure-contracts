// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

import {IAliasRegistry} from "../interfaces/utils/IAliasRegistry.sol";

///////////////////////////////////////////////////////////////
///░██████╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗///
///██╔════╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝///
///╚█████╗░██║░░██║██║░░░░░██║░░╚═╝██║░░░██║██████╔╝█████╗░░///
///░╚═══██╗██║░░██║██║░░░░░██║░░██╗██║░░░██║██╔══██╗██╔══╝░░///
///██████╔╝╚█████╔╝███████╗╚█████╔╝╚██████╔╝██║░░██║███████╗///
///╚═════╝░░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝///
/// @title AliasRegistry, a registry for contract implementations and their aliases for easy lookup
/// @author tempest-sol <tempest@solcure.io>
contract AliasRegistry is IAliasRegistry, Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;
      ///////////////////
     ///   Storage   ///
    ///////////////////
    EnumerableSet.AddressSet private _implementations;
    mapping(address => bytes16) private _implAliasMappings;
    mapping(bytes16 => address) private _aliasImplMappings;
      ///////////////////////
     ///   Constructor   ///
    ///////////////////////
    constructor() Ownable() { }

    /// @notice Registers an implementation with an alias
    /// @dev Only the owner can register an alias
    /// @param implementation The implementation address
    /// @param _alias The alias to register
    /// @custom:modifier onlyOwner Validates the caller is the owner
    /// @custom:revert AliasAlreadyRegistered
    /// @custom:emit AliasRegistered
    function registerAlias(address implementation, bytes16 _alias) external onlyOwner {
        if(!_implementations.add(implementation)) revert AliasAlreadyRegistered(_alias);
        _implAliasMappings[implementation] = _alias;
        _aliasImplMappings[_alias] = implementation;
        
        emit AliasRegistered(implementation, _alias);
    }

    /// @notice Removes an alias from the registry
    /// @dev Only the owner can remove an alias
    /// @param _alias The alias to remove
    /// @custom:modifier onlyOwner Validates the caller is the owner
    /// @custom:revert AliasNotRegistered
    /// @custom:emit AliasRemoved
    function removeAlias(bytes16 _alias) external onlyOwner {
        address impl = _aliasImplMappings[_alias];
        if(!_implementations.remove(impl)) revert AliasNotRegistered(_alias);
        delete _aliasImplMappings[_alias];
        delete _implAliasMappings[impl];
        
        emit AliasRemoved(impl, _alias);
    }

    /// @inheritdoc IAliasRegistry
    function getAlias(address implementation) external view returns (bytes16) {
        return _implAliasMappings[implementation];
    }

    /// @inheritdoc IAliasRegistry
    function getImplementation(bytes16 _alias) external view returns (address) {
        return _aliasImplMappings[_alias];
    }
}