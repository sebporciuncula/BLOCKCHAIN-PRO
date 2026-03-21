//https://github.com/sebporciuncula/BLOCKCHAIN-PRO
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract AntiHackanaLedger {
    mapping(address => uint256) public userBalances;

    function updateBalance(address _user, uint256 _newBalance) public {
        // This check ensures the address provided is not the "0x000..." address
        require(_user != address(0), "Invalid address: cannot be the zero address");
        
        userBalances[_user] = _newBalance;
    }

    function getBalance(address _user) public view returns (uint256) {
        return userBalances[_user];
    }
}