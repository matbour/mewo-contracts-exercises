// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { ERC20 } from "./ERC20.sol";

contract ERC20Test is Test {
  ERC20 exercise;

  function setUp() public {
    exercise = new ERC20();
  }
}
