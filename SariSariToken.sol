// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SariSariToken is ERC20 {
    address public owner;
    // 50,000 tokens with 18 decimal places
    uint256 public constant MAX_SUPPLY = 50000 * 1e18;

    // Task 1: Add onlyOwner modifier to restrict access
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized: Only the owner can perform this action");
        _;
    }

    /**
     * Task 2: Initialize owner and perform initial minting
     */
    constructor() ERC20("SariSari Token", "SST") {
        owner = msg.sender;
        
        // Initial stock: 10,000 SST
        // We use _mint (internal) because the public mint function has the onlyOwner modifier
        _mint(owner, 10000 * 1e18); 
    }

    /**
     * Task 3: Controlled minting with supply cap enforcement
     */
    function mint(address to, uint256 amount) public onlyOwner {
        // Enforce the max total supply limit
        // totalSupply() is a built-in ERC20 function that tracks current circulation
        require(totalSupply() + amount <= MAX_SUPPLY, "Minting failed: Exceeds MAX_SUPPLY cap");
        
        _mint(to, amount);
    }
}