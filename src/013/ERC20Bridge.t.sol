// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { Bridgeable, Dev, Cyber, ERC20Bridge } from "./ERC20Bridge.sol";

contract ERC20BridgeTest is Test {
  address user = makeAddr("user");

  Bridgeable dev;
  Bridgeable cyber;
  ERC20Bridge bridge;

  function setUp() public {
    dev = Bridgeable(address(new Dev()));
    cyber = Bridgeable(address(new Cyber()));
    bridge = new ERC20Bridge(address(dev), address(cyber));
  }

  function test_setBridge_once() public {
    vm.expectRevert(abi.encodeWithSelector(Bridgeable.BridgeAlreadyIntialized.selector));
    vm.prank(user);
    dev.setBridge(user);

    vm.expectRevert(abi.encodeWithSelector(Bridgeable.BridgeAlreadyIntialized.selector));
    vm.prank(user);
    cyber.setBridge(user);
  }

  function test_mint_onlyBridge() public {
    vm.expectRevert(abi.encodeWithSelector(Bridgeable.OnlyBridge.selector));
    dev.mint(user, 10000);
    vm.expectRevert(abi.encodeWithSelector(Bridgeable.OnlyBridge.selector));
    cyber.mint(user, 10000);
  }

  function test_burn_onlyBridge() public {
    vm.expectRevert(abi.encodeWithSelector(Bridgeable.OnlyBridge.selector));
    dev.burn(user, 10000);
    vm.expectRevert(abi.encodeWithSelector(Bridgeable.OnlyBridge.selector));
    cyber.burn(user, 10000);
  }

  function test_swapDev_pass(uint256 amount) public {
    amount = bound(amount, 1, 1000 ether);
    deal(address(dev), user, amount);

    vm.startPrank(user);
    dev.approve(address(bridge), amount);
    bridge.swapDev(amount);

    assertEq(cyber.balanceOf(user), amount * 3 / 2);
  }

  function test_swapCyber_pass(uint256 amount) public {
    amount = bound(amount, 1, 1000 ether);
    deal(address(cyber), user, amount);

    vm.startPrank(user);
    cyber.approve(address(bridge), amount);
    bridge.swapCyber(amount);

    assertEq(dev.balanceOf(user), amount * 2 / 3);
  }
}
