// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayAidVault {
    mapping(address => uint256) public claimable;
    address public owner;

    // Task 1: Event declarations for audit logs
    event AidDeposited(address indexed donor, address indexed recipient, uint256 amount);
    event AidClaimed(address indexed recipient, uint256 amount);
    event EmergencyWithdrawn(uint256 amount);

    // Task 2: Access control modifier
    modifier onlyOwner() {
        // We use msg.sender instead of tx.origin to prevent phishing
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Task 3: Set owner in constructor
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Task 4: Validated deposit function
     */
    function depositAid(address recipient) public payable {
        require(msg.value > 0, "Cannot send 0 ETH");
        claimable[recipient] += msg.value;
        
        emit AidDeposited(msg.sender, recipient, msg.value);
    }

    /**
     * @dev Task 5: Secure claim logic (CEI pattern)
     */
    function claimAid() public {
        uint256 amount = claimable[msg.sender];
        require(amount > 0, "Nothing to claim");

        // Effects: Reset balance BEFORE the transfer
        claimable[msg.sender] = 0;

        // Interaction: Transfer funds
        payable(msg.sender).transfer(amount);
        
        emit AidClaimed(msg.sender, amount);
    }

    /**
     * @dev Task 6: Secure emergency withdrawal
     */
    function emergencyWithdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        
        payable(owner).transfer(balance);
        
        emit EmergencyWithdrawn(balance);
    }
}