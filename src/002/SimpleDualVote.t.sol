// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { SimpleDualVote } from "./SimpleDualVote.sol";

contract SimpleDualVoteTest is Test {
  SimpleDualVote exercise;

  function setUp() public {
    exercise = new SimpleDualVote();
  }

  function _candidate1() internal returns (uint256 count) {
    (bool success, bytes memory data) =
      address(exercise).call(abi.encodeWithSignature("candidate1()"));
    assertTrue(success);
    (count) = abi.decode(data, (uint256));
  }

  function _candidate2() internal returns (uint256 count) {
    (bool success, bytes memory data) =
      address(exercise).call(abi.encodeWithSignature("candidate2()"));
    assertTrue(success);
    (count) = abi.decode(data, (uint256));
  }

  function _voteForCandidate1() internal {
    (bool success,) = address(exercise).call(abi.encodeWithSignature("voteForCandidate1()"));
    assertTrue(success);
  }

  function _voteForCandidate2() internal {
    (bool success,) = address(exercise).call(abi.encodeWithSignature("voteForCandidate2()"));
    assertTrue(success);
  }

  function test_voteForCandidate1() public {
    uint256 before = _candidate1();
    _voteForCandidate1();
    assertEq(_candidate1(), before + 1);
  }

  function test_voteForCandidate2() public {
    uint256 before = _candidate2();
    _voteForCandidate2();
    assertEq(_candidate2(), before + 1);
  }
}
