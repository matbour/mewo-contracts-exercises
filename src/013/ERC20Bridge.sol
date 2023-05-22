// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC20 } from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

abstract contract Bridgeable is ERC20 {
  error BridgeAlreadyIntialized();
  error OnlyBridge();

  /// Define the address of the bridge, who will become the only address allowed to mint/burn tokens.
  /// Only callable once.
  function setBridge(address bridge) external virtual;

  function mint(address to, uint256 amount) external virtual;

  function burn(address from, uint256 amount) external virtual;
}

contract Dev is ERC20 /*, Bridgeable */ {
  constructor() ERC20("Dev", "DEV") { }
}

contract Cyber is ERC20 /*, Bridgeable */ {
  constructor() ERC20("Cyber", "CYBER") { }
}

// Give two ERC20 contracts, DEV and CYBER, write a bridge that allow to exchange 2 DEV against 3 CYBER.
// Users will call `swapDev` to exchange DEV tokens against CYBER (ex 20 DEV => 30 CYBER).
// The bridge will call the `mint`/`burn` functions of the Dev/Cyber contracts to make the swap.
// Example: swapping 20 DEV against 30 CYBER = burning 20 DEV and minting 30 CYBER.
// Ensure that the bridge is the only address allowed to mint/burn tokens.
// Bridgeable.setBridge should be called in the constructor.
contract ERC20Bridge {
  Bridgeable dev;
  Bridgeable cyber;

  constructor(address _dev, address _cyber) { }

  function swapDev(uint256 devAmount) public { }

  function swapCyber(uint256 cyberAmount) public { }
}
