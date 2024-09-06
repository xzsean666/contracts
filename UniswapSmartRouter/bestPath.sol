pragma solidity >=0.7.6;
pragma abicoder v2;


// import '@uniswap/v3-periphery/contracts/interfaces/IQuoter.sol';
import './IQuoter.sol';


contract BestSwapRoute {
    IQuoter public immutable quoter;
    constructor(address _swapRouter, address _quoter) {
        swapRouter = ISwapRouter(_swapRouter);
        quoter = IQuoter(_quoter);
    }

    function getBestSwapRoute(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint24[] memory fees
    ) public returns (uint256 amountOut, uint24 bestFee) {
        uint256 bestAmountOut = 0;
        uint24 bestFeeRate = 0;

        for (uint256 i = 0; i < fees.length; i++) {
            try quoter.quoteExactInputSingle(tokenIn, tokenOut, fees[i], amountIn, 0) returns (uint256 amountOutForFee) {
                if (amountOutForFee > bestAmountOut) {
                    bestAmountOut = amountOutForFee;
                    bestFeeRate = fees[i];
                }
            } catch {
                continue;
            }
        }

        return (bestAmountOut, bestFeeRate);
    }

}
