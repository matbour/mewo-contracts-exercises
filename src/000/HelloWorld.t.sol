// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { HelloWorld } from "./HelloWorld.sol";

// Write a simple Solidity contract that prints "Hello, World!" when a specific function is called.
// The contract should have a public function named sayHello that returns the string "Hello, World!".
contract HelloWorldTest is Test {
  HelloWorld hello;

  function setUp() public {
    hello = new HelloWorld();
  }

  function test_sayHello() public {
    (bool success, bytes memory data) = address(hello).call(abi.encodeWithSignature("sayHello()"));
    assertTrue(success, "Call to sayHello() failed");

    (string memory message) = abi.decode(data, (string));
    assertEq(message, "Hello world");
  }
}
