//https://github.com/sebporciuncula/BLOCKCHAIN-PRO
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeCalculator {
    uint256[] public prices;
    uint256[] public quantities;

    // Called for each order (adds to the list)
    function calculateTotal(
        uint256 pricePerUnit,
        uint256 quantity
    ) public returns (uint256) {
        prices.push(pricePerUnit);
        quantities.push(quantity);
        return pricePerUnit * quantity;
    }

    // Computes total of all stored orders
    function calculateGrandTotal() public view returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 0; i < prices.length; i++) {
            total += prices[i] * quantities[i];
        }
        return total;
    }

    // Computes automatic change based on payment vs grand total
    function calculateChange(uint256 payment) public view returns (uint256) {
        uint256 grandTotal = calculateGrandTotal();
        require(payment >= grandTotal, "Insufficient payment.");
        return payment - grandTotal;
    }

    // Applies discount to the grand total
    function applyDiscount(uint256 discountPercent) public view returns (uint256) {
        require(discountPercent <= 100, "Invalid discount percentage.");
        uint256 grandTotal = calculateGrandTotal();
        return grandTotal - ((grandTotal * discountPercent) / 100);
    }

    // Splits the grand total among group members
    function splitBill(uint256 groupSize) public view returns (uint256) {
        require(groupSize > 0, "Group size must be greater than zero.");
        uint256 grandTotal = calculateGrandTotal();
        return grandTotal / groupSize;
    }

    // Optional: Reset orders (for fresh transactions)
    function resetOrders() public {
        delete prices;
        delete quantities;
    }
}