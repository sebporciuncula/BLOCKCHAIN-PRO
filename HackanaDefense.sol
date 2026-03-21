//https://github.com/sebporciuncula/BLOCKCHAIN-PRO
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title HackanaDefense
 * @dev Implements safety checks using assert() and revert() to protect critical data.
 */
contract HackanaDefense {
    uint256 public criticalData;
    address public owner;

    constructor() {
        // The person deploying the contract becomes the owner
        owner = msg.sender;
    }

    
    function updateCriticalData(uint256 _newData) public {
        criticalData = _newData;
      
        assert(criticalData >= 0);
    }

    
    function restrictedUpdate(uint256 _newData) public {
        // Check if the caller is the authorized owner
        if (msg.sender != owner) {
            // revert() allows you to return a specific error message and refund remaining gas.
            revert("Access denied: Only the owner can update critical data.");
        }
        
        criticalData = _newData;
    }
}