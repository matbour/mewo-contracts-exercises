// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { EnumerableRoles } from "./EnumerableRoles.sol";

contract EnumerableRolesTest is Test {
  bytes ownerMessage = bytes("Ownable: caller is not the owner");
  address owner = makeAddr("owner");

  EnumerableRoles exercise;

  function setUp() public {
    vm.prank(owner);
    exercise = new EnumerableRoles();
  }

  function assertContains(bytes32[] memory roles, bytes32 role) internal pure returns (bool) {
    uint256 l = roles.length;

    for (uint256 i; i < l;) {
      if (roles[i] == role) {
        return true;
      }

      unchecked {
        ++i;
      }
    }

    return false;
  }

  function test_grantRole_revertOnlyOwner(bytes32 role, address who) public {
    vm.expectRevert(ownerMessage);
    exercise.grantRole(role, who);
    assertFalse(exercise.hasRole(role, who));
  }

  function test_grantRole_pass(bytes32 role, address who) public {
    vm.prank(owner);
    exercise.grantRole(role, who);
    assertTrue(exercise.hasRole(role, who));
  }

  function test_revokeRole_revertOnlyOwner(bytes32 role, address who) public {
    vm.prank(owner);
    exercise.grantRole(role, who);
    assertTrue(exercise.hasRole(role, who));

    vm.expectRevert(ownerMessage);
    exercise.revokeRole(role, who);
    assertTrue(exercise.hasRole(role, who));
  }

  function test_revokeRole_pass(bytes32 role, address who) public {
    vm.prank(owner);
    exercise.grantRole(role, who);
    assertTrue(exercise.hasRole(role, who));

    vm.prank(owner);
    exercise.revokeRole(role, who);
    assertFalse(exercise.hasRole(role, who));
  }

  function test_memberOf_pass(bytes32 role1, bytes32 role2, bytes32 role3, address who) public {
    vm.assume(role1 != role2 && role2 != role3);

    vm.startPrank(owner);
    exercise.grantRole(role1, who);
    exercise.grantRole(role2, who);
    exercise.grantRole(role3, who);
    vm.stopPrank();

    bytes32[] memory roles = exercise.memberOf(owner);
    assertEq(roles.length, 3);
    assertContains(roles, role1);
    assertContains(roles, role2);
    assertContains(roles, role3);
  }
}
