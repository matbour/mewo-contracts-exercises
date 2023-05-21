// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { SimpleAuction } from "./SimpleAuction.sol";

contract SimpleAuctionTest is Test {
  SimpleAuction exercise;

  function setUp() public {
    exercise = new SimpleAuction();
  }

  function _highestBid() internal returns (uint256 highestBid) {
    (bool success, bytes memory data) =
      address(exercise).call(abi.encodeWithSignature("highestBid()"));
    assertTrue(success);
    (highestBid) = abi.decode(data, (uint256));
  }

  function _placeBid(uint256 amount) internal {
    (bool success,) = address(exercise).call(abi.encodeWithSignature("placeBid(uint256)", amount));
    assertTrue(success);
  }

  function test_placeBid_increase(uint256 a, uint256 b) public {
    vm.assume(a < b);
    _placeBid(a);
    assertEq(_highestBid(), a);

    _placeBid(b);
    assertEq(_highestBid(), b);
  }

  function test_placeBid_lowerThan(uint256 a, uint256 b) public {
    vm.assume(a > b);
    _placeBid(a);
    assertEq(_highestBid(), a);

    _placeBid(b); // noop
    assertEq(_highestBid(), a);
  }
}
