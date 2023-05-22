// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { IERC20 } from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

// Create a contract that allow users to buy an ERC20 (Mewo) tokens with ethers.
// The Crowdsale contract will automatically receive 1,000,000,000 tokens (e.g mewo.balanceOf(address(Crowdsale)) == 1e9).
// Token will be sold with the rate: 1 ether = 10000 tokens.
// As always, add withdraw functiononly callable the owner of the contract but use the Ownable contract from the OpenZeppelin library.
contract Crowdsale {
  uint256 public constant RATE = 10000;
  IERC20 token;

  constructor(IERC20 _token) { }

  function buy() public payable { }
}
