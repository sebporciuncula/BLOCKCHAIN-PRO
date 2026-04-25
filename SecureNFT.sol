// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Task 1: Import OpenZeppelin contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SecureNFT is ERC721URIStorage, Ownable {
    uint256 public totalSupply;
    uint256 public maxSupply = 100;

    // Constructor initializes the NFT name, symbol, and sets the contract owner
    constructor() ERC721("SanJuanNFT", "SJN") Ownable(msg.sender) {}

    /**
     * @dev Task 2: Implement the mintNFT function
     * - onlyOwner: Restricts access to the contract owner
     * - require: Ensures the supply does not exceed the limit
     */
    function mintNFT(address recipient, string memory tokenURI) public onlyOwner {
        // 1. Check if the max supply has been reached
        require(totalSupply < maxSupply, "Max NFT supply reached");

        // 2. Increment the total supply for the new Token ID
        totalSupply++;

        // 3. Mint the token to the recipient
        _mint(recipient, totalSupply);

        // 4. Set the metadata URI (IPFS link, JSON, etc.)
        _setTokenURI(totalSupply, tokenURI);
    }
}