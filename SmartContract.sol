// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CommunityFund {

    address public fundOwner;
    uint256 public totalDonations;

    constructor() {
        fundOwner = msg.sender;
    }

    function donate(uint256 amount) public {
        require(amount > 0, "Donation must be greater than zero");

        totalDonations += amount;
    }

    function withdraw(uint256 amount) public {
        require(msg.sender == fundOwner, "Only the owner can withdraw");
        require(amount <= totalDonations, "Not enough funds");

        totalDonations -= amount;
    }
}