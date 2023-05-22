// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Ownable } from "openzeppelin-contracts/contracts/access/Ownable.sol";

// Sometimes, the owner pattern is not sufficient to properly address the autorisation logic.
// Write a role-based autorisation pattern, where only the owner of the contract can grant role.
contract EnumerableRoles is Ownable {
  bytes32 public constant ROLE1 = keccak256("ROLE1");
  bytes32 public constant ROLE2 = keccak256("ROLE2");
  bytes32 public constant ROLE3 = keccak256("ROLE3");
  bytes32 public constant ROLE4 = keccak256("ROLE4");
  bytes32 public constant ROLE5 = keccak256("ROLE5");
  // etc.

  /// Check if an address has the designated role.
  function hasRole(bytes32 role, address who) public returns (bool) { }

  /// Grant a role to any address. Only callable by the owner.
  function grantRole(bytes32 role, address who) public returns (bool) { }

  /// Revoke a role from any address. Only callable by the owner.
  function revokeRole(bytes32 role, address who) public returns (bool) { }

  /// Allow sender to renounce to a role.
  function renounceRole(bytes32 role) public returns (bool) { }

  /// Get the roles of a given address.
  function memberOf(address who) public returns (bytes32[] memory) { }
}
