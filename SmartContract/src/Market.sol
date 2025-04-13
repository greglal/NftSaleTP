// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {EUR} from "./EUR.sol";
import {GrendyCard} from "./GrendyCard.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Market is Ownable {
    EUR public eur;
    GrendyCard public grendyCard;
    uint256 public immutable price;

    constructor(EUR newEUR, GrendyCard newGrendyCard) Ownable(msg.sender) {
        eur = newEUR;
        grendyCard = newGrendyCard;
        price = 10*10**eur.decimals();
    }

    function getTotalPrice(uint256 quantity) public view returns(uint256) {
        uint256 base = price * quantity;
        return base;
    }

    function purchase(uint256 quantity) external {
        eur.transferFrom(msg.sender, owner(), getTotalPrice(quantity));
        grendyCard.mintTo(msg.sender, quantity);
    }
}