// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { Donation } from "./Donation.sol";

contract DonationTest is Test {
  address admin = makeAddr("admin");

  Donation exercise;

  function setUp() public {
    vm.prank(admin);
    exercise = new Donation();
  }

  function _donated(address who) internal returns (uint256 amount) {
    (bool success, bytes memory data) =
      address(exercise).call(abi.encodeWithSignature("donated(address)", who));
    assertTrue(success);
    (amount) = abi.decode(data, (uint256));
  }

  function _donate(uint256 amount) internal returns (bool success) {
    (success,) = address(exercise).call{ value: amount }(abi.encodeWithSignature("donate()"));
  }

  function _withdraw() internal returns (bool success) {
    (success,) = address(exercise).call(abi.encodeWithSignature("withdraw()"));
  }

  function test_donate_revertZero(address user) public {
    vm.assume(user != address(0));

    uint256 balanceBefore = address(exercise).balance;
    vm.prank(user);
    assertFalse(_donate(0));

    assertEq(_donated(user), 0);
    assertEq(address(exercise).balance, balanceBefore);
  }

  function test_donate_pass(address user, uint256 amount) public {
    vm.assume(user != address(0));
    vm.assume(amount > 0);

    uint256 balanceBefore = address(exercise).balance;

    hoax(user, amount);
    assertTrue(_donate(amount));

    assertEq(_donated(user), amount);
    assertEq(address(exercise).balance, balanceBefore + amount);
  }

  function test_withdraw_revertNotSender(uint256 amount) public {
    vm.assume(amount > 0);

    deal(address(exercise), amount);
    assertEq(address(exercise).balance, amount);

    assertFalse(_withdraw());
    assertEq(address(exercise).balance, amount);
  }

  function test_withdraw_pass(uint256 amount) public {
    vm.assume(amount > 0);

    deal(address(exercise), amount);
    assertEq(address(exercise).balance, amount);

    vm.prank(admin);
    assertTrue(_withdraw());
    assertEq(address(exercise).balance, 0);
  }
}
