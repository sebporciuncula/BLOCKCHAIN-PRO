// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract EWallet {

    function eWallet(uint wallet) public pure returns(uint, string memory) {

        if(wallet == 10) {
            wallet = wallet + 10;
            return (wallet, "Success");
        }

        else {
            return (wallet,"Insufficient");
        }
    }
}