// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrafficLightManager {
    // Maps intersection names (e.g., "Main St") to their current light color
    mapping(string => string) public lightState;

    // Task 1: Initialize default states in the constructor
    constructor() {
        lightState["intersection1"] = "red";
        lightState["intersection2"] = "red";
    }

    /**
     * @dev Task 2: Change the traffic light state dynamically with validation
     * @param intersection The name of the intersection to update
     * @param newState The new color ("red", "yellow", or "green")
     */
    function changeLight(string memory intersection, string memory newState) public {
        // Solidity cannot compare strings directly using ==. 
        // We must hash them using keccak256 first.
        require(
            keccak256(abi.encodePacked(newState)) == keccak256(abi.encodePacked("red")) ||
            keccak256(abi.encodePacked(newState)) == keccak256(abi.encodePacked("yellow")) ||
            keccak256(abi.encodePacked(newState)) == keccak256(abi.encodePacked("green")),
            "Invalid state! State must be 'red', 'green', or 'yellow'."
        );

        // If validation passes, update the mapping
        lightState[intersection] = newState;
    }
}