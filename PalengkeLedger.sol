//https://github.com/sebporciuncula/BLOCKCHAIN-PRO
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeLedger {
    // 1. Moved state variables INSIDE the contract block
    string public vendorName;
    uint256 public totalSales;
    bool public transactionStatus;
    
    
    mapping(address => uint256) public vendorSales;

    function recordSale(
        address _vendor,
        string memory _vendorName,
        uint256 _saleAmount
    ) public {
        vendorName = _vendorName;
        totalSales += _saleAmount;
        vendorSales[_vendor] += _saleAmount;
        transactionStatus = true;
    }

    
    function isTransactionSuccessful() public view returns (bool) {
        return transactionStatus;
    }
}