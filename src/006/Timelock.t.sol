// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { Timelock } from "./Timelock.sol";

contract TimelockTest is Test {
  address owner = makeAddr("owner");

  uint256 public constant MAX_SAFE_TIMESTAMP = 253402300800; // January 1 10000
  uint256 public constant MAX_SAFE_VALUE = 1 << 96 - 1;

  function test_owner(uint256 releaseDate, uint256 value) public {
    releaseDate = bound(releaseDate, 1, MAX_SAFE_TIMESTAMP);
    value = bound(value, 0, MAX_SAFE_VALUE);

    Timelock exercise = new Timelock{value: value}(owner, releaseDate);
    (bool success, bytes memory data) = address(exercise).call(abi.encodeWithSignature("owner()"));
    assertTrue(success);

    (address actualOwner) = abi.decode(data, (address));
    assertEq(actualOwner, owner);
  }

  function test_releaseDate(uint256 releaseDate, uint256 value) public {
    releaseDate = bound(releaseDate, 1, MAX_SAFE_TIMESTAMP);
    value = bound(value, 0, MAX_SAFE_VALUE);

    Timelock exercise = new Timelock{value: value}(owner, releaseDate);
    (bool success, bytes memory data) =
      address(exercise).call(abi.encodeWithSignature("releaseDate()"));
    assertTrue(success);

    (uint256 actualReleaseDate) = abi.decode(data, (uint256));
    assertEq(actualReleaseDate, releaseDate);
  }

  function test_withdraw_revertNotOwner(uint256 releaseDate, uint256 value) public {
    releaseDate = bound(releaseDate, 1, MAX_SAFE_TIMESTAMP);
    value = bound(value, 0, MAX_SAFE_VALUE);

    vm.warp(releaseDate + 1);

    Timelock exercise = new Timelock{value: value}(owner, releaseDate);
    (bool success,) = address(exercise).call(abi.encodeWithSignature("withdraw()"));
    assertFalse(success);
  }

  function test_withdraw_revertTooEarly(uint256 releaseDate, uint256 actual, uint256 value) public {
    releaseDate = bound(releaseDate, 1, MAX_SAFE_TIMESTAMP);
    actual = bound(actual, 0, releaseDate - 1);
    value = bound(value, 0, MAX_SAFE_VALUE);
    vm.warp(actual);

    Timelock exercise = new Timelock{value: value}(owner, releaseDate);

    vm.prank(owner);
    (bool success,) = address(exercise).call(abi.encodeWithSignature("withdraw()"));
    assertFalse(success);
  }

  function test_withdraw_pass(uint256 releaseDate, uint256 value) public {
    releaseDate = bound(releaseDate, 1, MAX_SAFE_TIMESTAMP);
    value = bound(value, 1, MAX_SAFE_VALUE);
    vm.warp(releaseDate + 1);

    Timelock exercise = new Timelock{value: value}(owner, releaseDate);

    vm.prank(owner);
    (bool success,) = address(exercise).call(abi.encodeWithSignature("withdraw()"));
    assertTrue(success);
  }
}
