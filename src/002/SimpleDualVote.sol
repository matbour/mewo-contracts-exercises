// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Implement a basic voting contract where users can vote for one of two candidates, `candidate1` and `candidate2`.
// The contract should have two public variables to store the vote counts for each candidate and two public functions:
// voteForCandidate1 and voteForCandidate2.
// Each function should increment the respective candidate's vote count when called.
contract SimpleDualVote {
  uint256 public candidate1;
  uint256 public candidate2;

  function voteForCandidate1() public {
    candidate1++;
  }

  function voteForCandidate2() public {
    candidate2++;
  }
}
