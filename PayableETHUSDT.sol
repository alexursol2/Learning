pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceFeed {
    AggregatorV3Interface internal priceFeed;

    constructor() {
        priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419); 
        // address of ETH/Tether price feed on Chainlink
    }

    function getEthTetherPrice() payable public returns (uint256) {
        // require payment to use function
        require(msg.value > 0, "Please provide a valid payment to use this function."); 
        (, int price, , , ) = priceFeed.latestRoundData();
        // convert Chainlink price (which has 18 decimals) to standard ETH/Tether price (which has 8 decimals)
        return uint256(price) * 1e10; 
    }
}
