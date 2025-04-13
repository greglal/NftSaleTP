// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {EUR} from "../src/EUR.sol";

contract EURTest is Test {
    EUR public eur;

    function setUp() public {
        eur = new EUR();
    }

    function test_decimals() public view {
        assertEq(eur.decimals(), 4);
    }

    function test_mint_self() public {
        address greg = makeAddr("Greg");

        vm.prank(greg);
        eur.mint(greg, 20);
        assertEq(eur.balanceOf(greg), 20);
    }

    function test_mint_other() public {
        address greg = makeAddr("Greg");
        address sandy = makeAddr("Sandy");

        vm.prank(greg);
        eur.mint(sandy, 20);
        assertEq(eur.balanceOf(greg), 0);
        assertEq(eur.balanceOf(sandy), 20);
    }
}