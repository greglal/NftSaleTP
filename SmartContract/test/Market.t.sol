// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {IERC20Errors} from "@openzeppelin/contracts/interfaces/draft-IERC6093.sol";
import {Market} from "../src/Market.sol";
import {EUR} from "../src/EUR.sol";
import {GrendyCard} from "../src/GrendyCard.sol";

contract MarketTest is Test {
    address owner = makeAddr("owner");
    EUR public eur;
    GrendyCard public grendyCard;
    Market public market;

    function setUp() public {
        vm.startPrank(owner);
        eur = new EUR();
        grendyCard = new GrendyCard();
        market = new Market(eur, grendyCard);

        grendyCard.setShop(address(market));
        vm.stopPrank();
    }

    function test_getTotalPrice() public view {
        uint256 quantity = 3;
        uint256 expectedPrice = 300000;

        assertEq(market.getTotalPrice(quantity), expectedPrice);
    }

    function test_purchase_ok() public {
        address greg = makeAddr("greg");
        uint256 quantity = 3;
        uint256 expectedPrice = market.getTotalPrice(quantity);

        eur.mint(greg, expectedPrice);

        vm.prank(greg);
        eur.approve(address(market), expectedPrice);

        vm.prank(greg);
        market.purchase(quantity);

        assertEq(eur.balanceOf(greg),0);
        assertEq(eur.balanceOf(market.owner()), expectedPrice);
        assertEq(grendyCard.balanceOf(greg), quantity);
    }

    function test_purchase_notEnoughEUR() public {
        address greg = makeAddr("greg");
        uint256 quantity = 3;
        uint256 expectedPrice = market.getTotalPrice(quantity);
        uint256 actualBalance = expectedPrice  - 10;

        eur.mint(greg, actualBalance);

        vm.prank(greg);
        eur.approve(address(market), expectedPrice);

        vm.prank(greg);
        vm.expectRevert(abi.encodeWithSelector(IERC20Errors.ERC20InsufficientBalance.selector, greg, actualBalance,
            expectedPrice));
        market.purchase(quantity);

        assertEq(eur.balanceOf(greg), actualBalance);
        assertEq(eur.balanceOf(market.owner()), 0);
        assertEq(grendyCard.balanceOf(greg), 0);
    }

}