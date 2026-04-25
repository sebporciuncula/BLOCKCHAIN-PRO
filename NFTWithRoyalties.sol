// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTWithRoyalties {
    address public creator;
    uint256 public royaltyPercentage; // e.g., 10 for 10%
    address public currentOwner;

    constructor(address _creator, uint256 _percentage) {
        creator = _creator;
        royaltyPercentage = _percentage;
        currentOwner = _creator;
    }

    /**
     * @dev Handles the sale and transfer of the NFT.
     * @param buyer The address of the person buying the NFT.
     * @param salePrice The total amount of ETH the buyer must pay.
     */
    function transferNFT(address buyer, uint256 salePrice) public payable {
        // Step 0: Validation
        require(msg.value == salePrice, "Incorrect payment amount");
        require(buyer != address(0), "Invalid buyer address");

        // Step 1: Calculate the royalty for the creator
        uint256 royalty = (salePrice * royaltyPercentage) / 100;

        // Step 2: Calculate the net amount for the seller (current owner)
        uint256 sellerAmount = salePrice - royalty;

        // Step 3: Distribution of Funds
        // Send the royalty cut to the original creator
        payable(creator).transfer(royalty);
        
        // Send the remaining balance to the current owner (the seller)
        payable(currentOwner).transfer(sellerAmount);

        // Step 4: Update Ownership
        // The buyer now becomes the currentOwner for the next sale
        currentOwner = buyer;
    }
}