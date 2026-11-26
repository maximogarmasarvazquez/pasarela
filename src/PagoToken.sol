
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract PagoToken is ERC20, ERC20Permit, Ownable {
    constructor(address initialOwner, uint256 initialSupply)
        ERC20("CertiChain Test Token", "CCT")
        ERC20Permit("CertiChain Test Token")
        Ownable(initialOwner)
    {
        _mint(initialOwner, initialSupply);
    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }
}