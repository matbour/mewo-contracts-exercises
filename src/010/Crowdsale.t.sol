// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { Mewo } from "./Mewo.sol";
import { Crowdsale } from "./Crowdsale.sol";

contract CrowdsaleTest is Test {
  Mewo mewo;
  Crowdsale sale;

  address user = makeAddr("user");

  function setUp() public {
    mewo = new Mewo();
    sale = new Crowdsale(mewo);
    deal(address(mewo), address(sale), 1e9 * 1e18);
    assertEq(mewo.balanceOf(address(sale)), 1e9 * 1e18);
  }

  function test_pay() public {
    hoax(user, 1 ether);
    sale.buy{ value: 1 ether }();
    assertEq(mewo.balanceOf(user), 10000e18);
  }
}
