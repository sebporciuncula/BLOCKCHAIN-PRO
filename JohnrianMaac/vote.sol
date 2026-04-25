// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract VoterChecker {

    function Voter(uint age) public pure returns(string memory) {

        if (age >= 18) {

            return ("Eligible to vote");

        } else {

            return ("Not eligible");
            
        }
    }
}