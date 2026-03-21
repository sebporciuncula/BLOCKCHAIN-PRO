//https://github.com/sebporciuncula/BLOCKCHAIN-PRO
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EfficientDataTransfer {
    function echoData(string calldata data) external pure returns (string memory) {
        return data;
    }

    function memoryData(string memory data) public pure returns (string memory) {
        return data;
    }
}