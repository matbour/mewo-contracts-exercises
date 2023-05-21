// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { MyAge } from "./MyAge.sol";

contract MyAgeTest is Test {
  MyAge exercise;

  function setUp() public {
    exercise = new MyAge();
  }

  function test_age() public {
    (bool success, bytes memory data) = address(exercise).call(abi.encodeWithSignature("getAge()"));
    assertTrue(success, "Exercise001.getAge() call failed");

    (uint256 age) = abi.decode(data, (uint256));
    assertEq(age, 30, "Age is not equal to 30");
  }
}
