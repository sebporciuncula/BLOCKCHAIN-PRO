// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev Interface for the ERC20 standard to allow this contract 
 * to communicate with the token contract.
 */
interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract SimpleStaker {
    IERC20 public stakingToken;
    uint256 public lockDuration = 60; // 1 minute

    struct Stake {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => Stake) public stakes;

    constructor(address _token) {
        stakingToken = IERC20(_token);
    }

    /**
     * @dev Task 1: Stake tokens
     * Requires the user to have called approve() on the token contract first.
     */
    function stake(uint256 amount) public {
        require(amount > 0, "Nothing to stake");

        // Use transferFrom to pull tokens from the user's wallet into this contract
        // This requires prior approval from the user
        bool success = stakingToken.transferFrom(msg.sender, address(this), amount);
        require(success, "Transfer failed");

        // Record the stake and set the future unlock time
        stakes[msg.sender] = Stake(amount, block.timestamp + lockDuration);
    }

    /**
     * @dev Task 2: Unstake tokens with a 10% reward
     */
    function unstake() public {
        // Load the stake from storage into memory for efficiency
        Stake memory userStake = stakes[msg.sender];

        // Validation Checks
        require(userStake.amount > 0, "Nothing staked");
        require(block.timestamp >= userStake.unlockTime, "Still locked");

        // Calculate a 10% reward (Principal * 1.10)
        uint256 totalPayout = (userStake.amount * 110) / 100;

        // Reset the state BEFORE the transfer (CEI Pattern)
        delete stakes[msg.sender];

        // Send the tokens (principal + reward) back to the user
        bool success = stakingToken.transfer(msg.sender, totalPayout);
        require(success, "Withdrawal failed");
    }
}