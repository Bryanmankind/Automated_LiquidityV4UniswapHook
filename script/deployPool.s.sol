// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;
import {Script, console} from "forge-std/Script.sol";
import {LiquidityPool} from "../src/v4Pool.sol/liquidityPool.sol";

contract LiquidityPoolScript is Script {
    function run () public {
        vm.startBroadcast();

         LiquidityPool lp = new LiquidityPool(
        0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48, // USDC
        0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2, // WETH
        3000, // 0.3% fee
        60 // tick spacing
    );

    int24 tick = lp.createPool(address(0));

    console.log("Pool created with initial tick:", tick);
    vm.stopBroadcast();

    }
}