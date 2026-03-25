// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SecureDonation is Ownable, ReentrancyGuard {
    uint256 public totalDonations;

    mapping(address => uint256) public donations;

    constructor() Ownable(msg.sender) {}

    function donate() external payable nonReentrant {
        require(msg.value > 0, "Donation must be greater than zero.");
        donations[msg.sender] += msg.value;

        totalDonations += msg.value;
    }

    function withdraw() external onlyOwner nonReentrant {
        require(totalDonations > 0, "No funds to withdraw.");
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success, "Withdrawal failed.");
    }
}