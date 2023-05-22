// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { SimpleToken } from "./SimpleToken.sol";

contract SimpleTokenTest is Test {
  address admin = makeAddr("admin");
  SimpleToken exercise;

  function setUp() public {
    exercise = new SimpleToken(admin);
  }

  function _owner() internal returns (address owner) {
    (bool success, bytes memory data) = address(exercise).call(abi.encodeWithSignature("owner()"));
    assertTrue(success);
    (owner) = abi.decode(data, (address));
  }

  function _transferOwnership(address newOwner) internal returns (bool success) {
    (success,) =
      address(exercise).call(abi.encodeWithSignature("transferOwnership(address)", newOwner));
  }

  function _callBalanceOf(address to) internal returns (uint256 balanceOf) {
    (bool success, bytes memory data) =
      address(exercise).call(abi.encodeWithSignature("balanceOf(address)", to));
    assertTrue(success);
    (balanceOf) = abi.decode(data, (uint256));
  }

  function _callTransfer(address to, uint256 amount) internal returns (bool success) {
    (success,) =
      address(exercise).call(abi.encodeWithSignature("transfer(address,uint256)", to, amount));
  }

  function _callMint(address to, uint256 amount) internal returns (bool success) {
    (success,) =
      address(exercise).call(abi.encodeWithSignature("mint(address,uint256)", to, amount));
  }

  function test_owner_initial() public {
    assertEq(_owner(), admin);
  }

  function test_transferOwnership_revertNonOwner(address newOwner) public {
    assertFalse(_transferOwnership(newOwner));
    assertEq(_owner(), admin);
  }

  function test_transferOwnership_pass(address newOwner) public {
    vm.prank(admin);
    assertTrue(_transferOwnership(newOwner));
    assertEq(_owner(), newOwner);
  }

  function test_mint_revertNonOwner(address recipient, uint256 amount) public {
    vm.assume(recipient != address(0));
    vm.assume(amount > 0);

    uint256 initial = _callBalanceOf(recipient);
    assertFalse(_callMint(recipient, amount));
    assertEq(_callBalanceOf(recipient), initial);
  }

  function test_mint_pass(address recipient, uint256 amount) public {
    vm.assume(recipient != address(0));
    vm.assume(amount > 0);

    uint256 initial = _callBalanceOf(recipient);
    vm.prank(admin);
    assertTrue(_callMint(recipient, amount));
    assertEq(_callBalanceOf(recipient), initial + amount);
  }

  function test_transfer_revertInsufficient(
    address user,
    address recipient,
    uint256 amount,
    uint256 delta
  ) public {
    vm.assume(user != address(0));
    vm.assume(amount > 0);
    vm.assume(delta > amount);

    vm.prank(admin);
    assertTrue(_callMint(user, amount));

    vm.prank(user);
    assertFalse(_callTransfer(recipient, delta));
  }

  function test_transfer_pass(address user, address recipient, uint256 amount, uint256 transfered)
    public
  {
    vm.assume(user != address(0));
    vm.assume(amount > 0);
    vm.assume(transfered < amount);

    vm.prank(admin);
    assertTrue(_callMint(user, amount));

    vm.prank(user);
    assertTrue(_callTransfer(recipient, transfered));
    assertEq(_callBalanceOf(recipient), transfered);
  }
}
