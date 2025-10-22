
## LiquidityV4UniswapHook

A hands-on learning project that demonstrates how to create and manage liquidity pools using Uniswap v4’s core architecture.
This project focuses on building a custom Solidity contract that integrates with Uniswap v4’s v4-core libraries to deploy pools and add liquidity programmatically, helping developers understand the inner workings of the next-generation AMM design.

## Overview

Uniswap v4 introduces a new level of flexibility through Hooks, Singleton Pools, and customizable liquidity logic.
This project serves as an educational sandbox to explore how pools are created and how liquidity can be added directly through smart contracts.

The contract implements:

A function to create liquidity pools via PoolManager and PoolKey.

A function to add liquidity to an existing pool.

Examples of pool initialization using sqrtPriceX96 for different token ratios.

## Key Concepts

PoolKey: Defines the unique identity of each pool (pair, fee, and tick spacing).

PoolManager: Central entry point for creating and managing pools.

Liquidity Management: Adding or removing liquidity using precise tick ranges.

Hooks: Extend pool behavior without forking Uniswap v4.

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### 🧑‍💻 Author

Bryan Conquer
Blockchain Smart Contract Developer