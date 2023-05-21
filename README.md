# Smart contract exercises for Mewo Informatique School

## General instructions

1. Install Foundry ands the necessary toolchain
2. Clone this repository with git
3. Install the Foundry dependencies with

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

Example: for the exercise 000:

```shell
forge test --match-path 'src/000/*.sol'
```
