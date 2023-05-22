// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Create a Solidity contract that represents a simple bank account.
// No security feature required: everybody can access to the bank account.
// The contract should expose a public uint256 `balance` variable that represents the account balance.
// Users can interact with the bank account using two functions.
// - The deposit function should take an `amount` as a parameter and increase the account `balance` by that `amount`.
// - The withdraw function should take an `amount` and decrease the account `balance` by that `amount` if sufficient funds are available (e.g. `balance` > 0).
contract SimpleBank {
  uint256 public balance;

  function deposit(uint256 amount) public {
    balance += amount;
  }

  function withdraw(uint256 amount) public {
    require(amount <= balance, "Insufficient balance");
    balance -= amount;
  }
}
