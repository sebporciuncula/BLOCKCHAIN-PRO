// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureFund {
    address public owner;
    uint256 public totalDonations;

    constructor() {
        owner = msg.sender;
    }

    function donate(uint256 amount) public payable {
        require(msg.value > 0, "Donation must be greater than zero");
        require(msg.value == amount, "Amount must match the ETH sent");
        totalDonations += msg.value;
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(amount <= address(this).balance, "Not enough funds");
        totalDonations -= amount;
        payable(owner).transfer(amount);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
}