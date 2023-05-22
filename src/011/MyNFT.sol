// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC721 } from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

// Write a sale contract that allow users to purchase NFTs.
// Maxmimum supply should be 10,000.
// Each NFT will be sold at 0.05 ether for the first 1,000 units, them 0. ether for the rest of the supply.
contract MyNFT is ERC721 {
  uint256 public constant EARLY = 0.05 ether;
  uint256 public constant NORMAL = 0.1 ether;

  error InsufficientValue(uint256 expected, uint256 actual);

  constructor() ERC721("MyNFT", "MNFT") { }

  function price(uint256 quantity) internal view returns (uint256) { }

  function purchase(uint256 quantity) external payable { }
}
