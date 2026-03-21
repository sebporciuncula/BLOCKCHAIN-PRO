//https://github.com/sebporciuncula/BLOCKCHAIN-PRO
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeTransactions {
    uint256[] public payments;

    function recordPayment(uint256 _amount) public {
        payments.push(_amount);
    }

    function getTotalPayments() public view returns (uint256) {
        return payments.length;
    }

    function getPayment(uint256 _index) public view returns (uint256) {
        require(_index < payments.length, "Invalid index.");
        return payments[_index];
    }
}