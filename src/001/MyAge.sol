// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Declare an unsigned integer variable `age` and initialize it to 30.
// Write a `getAge` function that displays the value of `age`.
contract MyAge {
  uint256 age = 30;

  function getAge() public view returns (uint256) {
    return age;
  }
}
