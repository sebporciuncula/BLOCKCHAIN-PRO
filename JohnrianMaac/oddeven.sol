// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract OddEven {

    function CheckOddEven(uint number) public pure returns(string memory) {
        if (number % 2 == 0) {
            return ("Even");
        } else {
            return ("Odd");
        }
    }
}