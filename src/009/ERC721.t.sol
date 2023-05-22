// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { ERC721 } from "./ERC721.sol";

contract ERC721Test is Test {
  ERC721 exercise;

  function setUp() public {
    exercise = new ERC721();
  }
}
