// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicPricing {
    /**
     * @dev Calculates dynamic pricing for a ride using percentage adjustments.
     * @param basePrice The base price of the ride.
     * @param demandFactor A percentage increase based on demand (e.g. 20 means +20%).
     * @param timeFactor A percentage increase based on time of day (e.g. 10 means +10%).
     * @return The dynamically calculated ride price.
     */
    function calculatePrice(
        uint256 basePrice,
        uint256 demandFactor,
        uint256 timeFactor
    ) public pure returns (uint256) {
        // 1. Apply demandFactor (e.g., 100 + 20% = 120)
        uint256 demandAdjustment = (basePrice * demandFactor) / 100;
        uint256 tempPrice = basePrice + demandAdjustment;

        // 2. Apply timeFactor on the NEW price (e.g., 120 + 10% = 132)
        uint256 timeAdjustment = (tempPrice * timeFactor) / 100;
        uint256 finalPrice = tempPrice + timeAdjustment;

        return finalPrice;
    }
}