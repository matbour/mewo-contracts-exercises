// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, stdStorage, StdStorage } from "forge-std/Test.sol";
import { ERC721 } from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import { MyNFT } from "./MyNFT.sol";

contract NFTSaleTest is Test {
  using stdStorage for StdStorage;

  MyNFT token;

  address user = makeAddr("user");

  function setUp() public {
    token = new MyNFT();
  }

  function test_purchase_revertInsufficientValue(uint256 actual) public {
    uint256 expected = token.EARLY();
    actual = bound(actual, 1, expected - 1);

    vm.expectRevert(abi.encodeWithSelector(MyNFT.InsufficientValue.selector, expected, actual));

    hoax(user, actual);
    token.purchase{ value: actual }(1);
    assertEq(token.balanceOf(user), 0);
  }

  function test_purchase_earlyOne() public {
    startHoax(user, token.EARLY());
    token.purchase{ value: token.EARLY() }(1);
    assertEq(token.balanceOf(user), 1);
  }

  function testFuzz_purchase_earlyMulti(uint256 quantity) public {
    quantity = bound(quantity, 1, 1000);
    uint256 value = token.EARLY() * quantity;

    startHoax(user, value);
    token.purchase{ value: value }(quantity);
    assertEq(token.balanceOf(user), quantity);
  }

  function testFuzz_purchase_normalMulti(uint256 quantity) public {
    quantity = bound(quantity, 1, 1000);
    uint256 value = token.NORMAL() * quantity;

    startHoax(user, value);
    token.purchase{ value: value }(quantity);
    assertEq(token.balanceOf(user), quantity);
  }
}
