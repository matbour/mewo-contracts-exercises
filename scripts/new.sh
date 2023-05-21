#!/bin/bash

if [ -z $1 ]; then
    echo "Missing exercise name, exiting"
    exit 1
fi

name=$1
last_id=$(ls src | tail -1 | sed 's/^0*//')
((new_id=last_id+1))

if [ $new_id -lt 10 ]; then
    new_id="00$new_id"
elif [ $new_id -lt 100 ]; then
    new_id="0$new_id"
fi

mkdir -p src/$new_id

cat >src/$new_id/$name.sol <<SOL
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Write instructions here
contract $name { }
SOL

cat >src/$new_id/$name.t.sol <<SOL
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { $name } from "./$name.sol";

contract ${name}Test is Test {
  $name exercise;

  function setUp() public {
    exercise = new $name();
  }
}
SOL