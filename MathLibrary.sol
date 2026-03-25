// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MathLibrary {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function multiply(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    function calculatePercentage(
        uint256 base,
        uint256 percent
    ) internal pure returns (uint256) {
        return (base * percent) / 100;
    }
}