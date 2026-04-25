// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LiquidityLocker {
    address public owner;
    uint256 public lockEnd;
    mapping(address => uint256) public deposits;

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Task 1: Accept deposits and set a global lock timer
     */
    function deposit() external payable {
        // Validation: Ensure user is actually sending something
        require(msg.value > 0, "Must send Ether");
        
        // Track the deposit in the mapping
        deposits[msg.sender] += msg.value;
        
        // Set the lock period to 60 seconds from the current block time
        // Note: In a real app, you might use unique timers per user
        lockEnd = block.timestamp + 60; 
    }

    /**
     * @dev Task 2: Securely withdraw funds after the lock expires
     */
    function withdraw() external {
        // 1. CHECK: Is the lock period over?
        require(block.timestamp >= lockEnd, "Still locked");
        
        // 2. CHECK: Does the user actually have funds?
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "No funds to withdraw");

        // 3. EFFECT: Reset the user's balance BEFORE the transfer (CEI Pattern)
        // This prevents the user from calling withdraw() again during the transfer
        deposits[msg.sender] = 0;

        // 4. INTERACTION: Send the funds
        payable(msg.sender).transfer(amount);
    }
}