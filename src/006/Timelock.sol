// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// A timelock wallet is a contract that holds funds until a certain date.
// Write a timelock contract that is hold funds until releaseDate (public variable).
// - Contract should be able to receive additional funds at any time (see Solidity receive function)
// - Only owner can call the `withdraw` function to withdraw the funds.
contract Timelock {
  constructor(address _owner, uint256 _releaseDate) payable { }
}
