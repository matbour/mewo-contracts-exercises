// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// It's time to start to create tokens!
// Create a contract that represents a token.
// Its constructor will include an address parameter that will be the `owner` of the contract.
// - owner() that returns who is the `owner` of the contract.
// - transferOwnership(address to) that changes who is the owner.
// - balanceOf(address who) that returns the balance of the address `who`.
// - transfer(address to, uint256 amount) that allow to transfer `amount` tokens to the address `to`. The sender must have enough tokens!
// - mint(address to, uint256 amount) that allow to mint `amount` tokens to the address `to`. Only owner cam mint tokens.
contract SimpleToken {
  constructor(address _owner) { }
}
