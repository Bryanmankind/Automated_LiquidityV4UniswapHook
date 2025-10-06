// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;
import {PoolKey} from "v4-core/src/types/PoolKey.sol";
import {IPoolManager} from "v4-core/src/interfaces/IPoolManager.sol";


contract LiquidityPool {

    address public currency0;
    address public currency1;
    uint24 public lpFee;
    int24 public tickSpacing;

    address public manager = 0x1F98431c8aD98523631AE4a59f267346ea31F984; // Uniswap V4 Pool Manager address
    uint160 public startingPrice = 79228162514264337593543950336; // 1:1 price ratio in Q64.96 format


    constructor(
        address _currency0,
        address _currency1,
        uint24 _lpFee,
        int24 _tickSpacing
    ) {
        currency0 = _currency0;
        currency1 = _currency1;
        lpFee = _lpFee;
        tickSpacing = _tickSpacing;
    }


    function createPool(address hookContract) external {
        // sort tokens to get the correct pool key
        (address token0, address token1) = _sortTokens(currency0, currency1);

        PoolKey memory pool = PoolKey({
        currency0: token0,
        currency1: token1,
        fee: lpFee,
        tickSpacing: tickSpacing,
        hooks: hookContract
     });

        IPoolManager(manager).initialize(pool, startingPrice);
    }

 function _sortTokens(address _currency0, address _currency1) internal pure returns (address token0, address token1) {
    require(_currency0 != _currency1, 'IDENTICAL_ADDRESSES');
    (token0, token1) = _currency0 < _currency1 ? (_currency0, _currency1) : (_currency1, _currency0);
    require(token0 != address(0), 'ZERO_ADDRESS');
}

   
}   
