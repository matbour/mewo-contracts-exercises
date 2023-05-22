// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Build a Solidity contract that represents a simple auction.
// The contract should have:
// - a public variable `highestBid` to store the highest bid
// - a public function `placeBid` that allows users to place a bid by providing an amount.
//   If the `highestBid` is greater than the bid provided by the sender, the bid should be ignored
//   (e.g. highestBid remains unchanged).
contract SimpleAuction {
  uint256 public highestBid;

  function placeBid(uint256 amount) public {
    if (amount > highestBid) {
      highestBid = amount;
    }
  }
}
