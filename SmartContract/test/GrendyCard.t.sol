// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {GrendyCard} from "../src/GrendyCard.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract GrendyCardTest is Test {
    address owner = makeAddr("owner");
    address market = makeAddr("market");
    GrendyCard public grendyCard;

    function setUp() public {
        vm.startPrank(owner);
        grendyCard = new GrendyCard();
        grendyCard.setShop(market);
        vm.stopPrank();
    }

    function test_constructor() public view {
        assertEq(grendyCard.name(), "GrendyCard");
        assertEq(grendyCard.symbol(), "GRENDYCARD");
        assertEq(grendyCard.owner(), owner);
    }

    function test_setShop_asNotOwner() public {
        address newMarket = makeAddr("newMarket");
        address notOwner = makeAddr("notOwner");

        vm.prank(notOwner);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, notOwner));
        grendyCard.setShop(newMarket);
        assertEq(grendyCard.shop(), market);
    }

    function test_mintTo_asShop() public {
        address greg = makeAddr("greg");
        uint256 quantity = 3;

        vm.prank(market);
        grendyCard.mintTo(greg, quantity);
        assertEq(grendyCard.balanceOf(greg), quantity);
    }

    function test_mintTo_asNotShop() public {
        address greg = makeAddr("greg");
        uint256 quantity=3;

        vm.prank(greg);
        vm.expectRevert(abi.encodeWithSelector(GrendyCard.NotShop.selector));
        grendyCard.mintTo(greg, quantity);

        assertEq(grendyCard.balanceOf(greg), 0);
    }
}