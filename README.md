# Smart contract exercises for Mewo Informatique School

## General instructions

1. Install [Foundry](https://book.getfoundry.sh/) and the necessary toolchain
2. [Fork](https://github.com/mathieu-bour/mewo-contracts-exercises/fork) this repository on GitHub
3. Clone the forked repository with git
4. Install the [Foundry](https://book.getfoundry.sh/) dependencies with

```shell
forge install
```

## Exercises

The exercises are located into the [src](./src/) directory.
Every exercise is independant, meaning that you can choose the order of completion of the exercises ; however I tried to globally sort them by ascending difficulty.

To check if your exercise is completed, run the associated test with:

```shell
forge test --match-path 'src/XXX/*.sol'
# or, for short
forge t --mp 'src/XXX/*.sol'
```

Example: for the [exercise 000](src/000/):

```shell
forge test --match-path 'src/000/*.sol'
```
