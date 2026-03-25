// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract UserRegistryV1 is Initializable {
    mapping(address => string) public userNames;

    function initialize() public initializer {
    }

    function registerUser(string memory name) public {
        userNames[msg.sender] = name;
    }

    function getUser(address user) public view returns (string memory) {
        return userNames[user];
    }
}

contract UserRegistryV2 is UserRegistryV1 {
    function updateUser(string memory newName) public {
        userNames[msg.sender] = newName;
    }
}