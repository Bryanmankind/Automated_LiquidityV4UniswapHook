// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;
import {PoolKey} from "v4-core/src/types/PoolKey.sol";
import {IHooks} from "v4-core/src/interfaces/IHooks.sol";
import {IPoolManager} from "v4-core/src/interfaces/IPoolManager.sol";
import {Currency} from "v4-core/src/types/Currency.sol";
import {PoolId, PoolIdLibrary} from "v4-core/src/types/PoolId.sol";


contract LiquidityPool {

    Currency public token0;
    Currency public token1;
    uint24 public lpFee; 
    int24 public tickSpacing;

    address public manager = 0x1F98431c8aD98523631AE4a59f267346ea31F984; // Uniswap V4 Pool Manager address
    uint160 public startingPrice = 79228162514264337593543950336; // 1:1 price ratio in Q64.96 format

    event PoolCreated(bytes32 indexed poolId, int24 initialTick, address hookContract);

    constructor(
        address _token0,
        address _token1,
        uint24 _lpFee,
        int24 _tickSpacing
    ) {
        token0 = Currency.wrap(_token0);
        token1 = Currency.wrap(_token1);
        lpFee = _lpFee;
        tickSpacing = _tickSpacing;
    }


    function createPool(address hookContract) external returns (int24 tick) {

        // Sort tokens
        (token0, token1) = token0 < token1 ? (token0, token1) : (token1, token0);

        PoolKey memory pool = PoolKey({
        currency0: token0,
        currency1: token1,
        fee: lpFee,
        tickSpacing: tickSpacing,
        hooks: IHooks(hookContract)
     });

        tick = IPoolManager(manager).initialize(pool, startingPrice);

        PoolId poolId = PoolIdLibrary.toId(pool);

        bytes32 id = PoolId.unwrap(poolId);

        emit PoolCreated(id, tick, hookContract);
    }
   
}   
