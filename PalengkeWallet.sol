// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Task 1: Import ReentrancyGuard
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract PalengkeWallet is ReentrancyGuard {
    mapping(address => uint256) public balances;

    /**
     * @dev Secured withdraw function
     * Task 2: Implement nonReentrant modifier and CEI pattern
     */
    function withdraw(uint256 amount) public nonReentrant {
        // 1. CHECKS: Verify the user has enough funds
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // 2. EFFECTS: Update the state (deduct balance) BEFORE the external call
        // Even if an attacker re-enters here, their balance is already 0
        balances[msg.sender] -= amount;

        // 3. INTERACTIONS: Send the ETH to the caller
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }

    // Allow the contract to receive ETH
    receive() external payable {
        balances[msg.sender] += msg.value;
    }
}