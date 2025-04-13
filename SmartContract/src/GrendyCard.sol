// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract GrendyCard is ERC721, Ownable {
    address public shop;
    uint public nextTokenId;
    error NotShop();
    constructor() ERC721("GrendyCard", "GRENDYCARD") Ownable(msg.sender) {}

    modifier onlyShop() {
        if(msg.sender != shop) {
            revert NotShop();
        }
        _;
    }

    function setShop(address newShop) external onlyOwner {
        shop = newShop;
    }

    function mintTo(address to, uint256 quantity) external onlyShop() {
        for (uint256 i=0; i<quantity; i++) {
            _mint(to, nextTokenId);
            nextTokenId++;
        }
    }
}