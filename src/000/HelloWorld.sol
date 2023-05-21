// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Write a simple Solidity contract that prints "Hello, World!" when a specific function is called.
// The contract should have a public function named sayHello that returns the string "Hello, World!".
contract HelloWorld {
  function sayHello() public pure returns (string memory) {
    return "Hello world";
  }
}
