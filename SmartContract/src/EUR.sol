// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EUR is ERC20 {
    constructor() ERC20("EUR", "EUR") {}

    function decimals() public pure override returns(uint8){
        return 4;
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}