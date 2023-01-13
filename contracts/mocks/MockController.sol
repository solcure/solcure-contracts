// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

import {ISolcurityPolicy, PolicyOwned} from "../access/PolicyOwned.sol";

contract MockController is PolicyOwned {

    constructor(ISolcurityPolicy policy) PolicyOwned(policy) { }

    function exampleFunction() external enforcePolicy {
        
    }

}