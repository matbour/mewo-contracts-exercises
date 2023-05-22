// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { Allowlist } from "./Allowlist.a.sol";

contract AllowlistTest is Test {
  address owner = makeAddr("owner");
  address operator = makeAddr("operator");
  address user = makeAddr("user");

  Allowlist exercise;

  function setUp() public {
    vm.startPrank(owner);
    exercise = new Allowlist();
    exercise.addOperator(operator);
    vm.stopPrank();
  }

  function test_addOperator_revertOnlyOwner() public {
    vm.expectRevert(abi.encodeWithSelector(Allowlist.OnlyOwner.selector));
    vm.prank(user);
    exercise.addOperator(user);
  }

  function test_addOperator_pass(address who) public {
    vm.prank(owner);
    exercise.addOperator(who);
    assertTrue(exercise.operators(who));
  }

  function test_removeOperator_revertOnlyOwner() public {
    vm.expectRevert(abi.encodeWithSelector(Allowlist.OnlyOwner.selector));
    vm.prank(user);
    exercise.removeOperator(user);
  }

  function test_removeOperator_pass(address who) public {
    vm.prank(owner);
    exercise.addOperator(who);
    assertTrue(exercise.operators(who));

    vm.prank(owner);
    exercise.removeOperator(who);
    assertFalse(exercise.operators(who));
  }

  function test_add_revertOnlyOperator() public {
    vm.expectRevert(abi.encodeWithSelector(Allowlist.OnlyOperator.selector));
    vm.prank(user);
    exercise.add(user);
  }

  function test_add_pass(address who) public {
    vm.prank(operator);
    exercise.add(who);
    assertTrue(exercise.isAllowed(who));
  }

  function test_removeOperator_revertOnlyOperator() public {
    vm.expectRevert(abi.encodeWithSelector(Allowlist.OnlyOperator.selector));
    vm.prank(user);
    exercise.remove(user);
  }

  function test_remove_pass(address who) public {
    vm.prank(operator);
    exercise.add(who);
    assertTrue(exercise.isAllowed(who));

    vm.prank(operator);
    exercise.remove(who);
    assertFalse(exercise.isAllowed(who));
  }
}
