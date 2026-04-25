// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayLending {
    struct LoanRequest {
        address borrower;
        uint256 amount;
        string reason;
        bool isFunded;
        address lender;
    }

    uint256 public loanCounter;
    mapping(uint256 => LoanRequest) public loans;

    event LoanRequested(uint256 loanId, address borrower, uint256 amount, string reason);
    event LoanFunded(uint256 loanId, address lender);

    /**
     * @dev Task 1: Request a new loan
     * Increments the counter and stores the loan details.
     */
    function requestLoan(uint256 amount, string memory reason) public {
        loanCounter++;
        
        // Initialize the struct and store it in the mapping
        loans[loanCounter] = LoanRequest({
            borrower: msg.sender,
            amount: amount,
            reason: reason,
            isFunded: false,
            lender: address(0) // No lender yet
        });

        emit LoanRequested(loanCounter, msg.sender, amount, reason);
    }

    /**
     * @dev Task 2: Fund a loan
     * Transfers ETH from the lender directly to the borrower.
     */
    function fundLoan(uint256 loanId) public payable {
        // Use 'storage' because we want to update the data on the blockchain
        LoanRequest storage loan = loans[loanId];

        // 1. CHECKS
        require(loan.borrower != address(0), "Loan does not exist");
        require(!loan.isFunded, "Loan already funded");
        require(msg.value == loan.amount, "Incorrect funding amount");

        // 2. EFFECTS
        loan.isFunded = true;
        loan.lender = msg.sender;

        // 3. INTERACTIONS
        // Send the lender's ETH (msg.value) to the borrower
        payable(loan.borrower).transfer(msg.value);

        emit LoanFunded(loanId, msg.sender);
    }
}