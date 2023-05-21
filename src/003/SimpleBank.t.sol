// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { SimpleBank } from "./SimpleBank.sol";

contract SimpleBankTest is Test {
  SimpleBank exercise;

  function setUp() public {
    exercise = new SimpleBank();
  }

  function _balance() internal returns (uint256 amount) {
    (bool success, bytes memory data) = address(exercise).call(abi.encodeWithSignature("balance()"));
    assertTrue(success);
    (amount) = abi.decode(data, (uint256));
  }

  function _deposit(uint256 amount) internal {
    (bool success,) = address(exercise).call(abi.encodeWithSignature("deposit(uint256)", amount));
    assertTrue(success);
  }

  function _withdraw(uint256 amount) internal {
    (bool success,) = address(exercise).call(abi.encodeWithSignature("withdraw(uint256)", amount));
    assertTrue(success);
  }

  function test_deposit_pass(uint256 expectedAmount) public {
    _deposit(expectedAmount);
    assertEq(_balance(), expectedAmount);
  }

  function test_withdraw_revert(uint256 depositAmount, uint256 withdrawAmount) public {
    vm.assume(depositAmount < withdrawAmount);
    _deposit(depositAmount);

    (bool success,) =
      address(exercise).call(abi.encodeWithSignature("withdraw(uint256)", withdrawAmount));
    assertFalse(success);
  }

  function test_withdraw_pass(uint256 depositAmount, uint256 withdrawAmount) public {
    vm.assume(depositAmount >= withdrawAmount);
    _deposit(depositAmount);
    _withdraw(withdrawAmount);
    assertEq(depositAmount, _balance() + withdrawAmount);
  }
}
