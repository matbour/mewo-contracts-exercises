// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC20 } from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Mewo is ERC20 {
  constructor() ERC20("Mewo", "MEWO") { }
}
