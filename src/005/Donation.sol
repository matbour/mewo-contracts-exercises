// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Write a contract that allow users to donate ether.
// - Only the account that deployed the contract is allowed to withdraw the funds via a `withdraw` function.
// - User will be able to donate ether to the contract via `donate`. Zero donation should be rejected.
// - Expose a `donated(address who)` function that allow to check how much an address has donated.
// Notes:
// - You can get the balance of the contract with address(this).payable
contract Donation {
  address public owner;
  mapping(address => uint256) public donated;

  constructor() {
    owner = msg.sender;
  }

  function donate() public payable {
    require(msg.value > 0, "Zero donation");
    donated[msg.sender] += msg.value;
  }

  function withdraw() public {
    require(msg.sender == owner, "Not owner");

    payable(owner).transfer(
      address(this).balance // balance of the contract
    );
  }
}
