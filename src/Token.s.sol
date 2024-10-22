// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract CalculatorPoint is ERC20 {
    uint8 private constant DECIMALS = 0; // Custom decimals

    uint256 private constant TOTAL_SUPPLY = 10000 * (10 ** DECIMALS); // Adjust total supply based on decimals

    constructor() ERC20("Calculator Point", "CP") {
        _mint(msg.sender, TOTAL_SUPPLY); // Mint all tokens to contract deployer
    }

    function decimals() public view virtual override returns (uint8) {
        return DECIMALS; // Override the default 18 decimals with a custom value
    }

}