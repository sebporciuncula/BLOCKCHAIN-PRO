// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract GradeChecker {

    function PassOrFail(uint grade) public pure returns(string memory) {

        if (grade >= 75) {

            return ("Passed");

        } else {

            return ("Failed");

        }
    }
}