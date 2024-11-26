// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SmartContract {

    uint256 public storedNumber;
    address public owner;

    // Event to emit when a number is successfully updated
    event NumberUpdated(uint256 oldNumber, uint256 newNumber);

    // Constructor to initialize the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Function to store a number, requires the sender to be the owner
    function storeNumber(uint256 _number) public {
        // The require statement ensures the sender is the owner
        require(msg.sender == owner, "Only the owner can store a number");
        
        uint256 oldNumber = storedNumber;
        storedNumber = _number;

        // Emit event after updating the stored number
        emit NumberUpdated(oldNumber, storedNumber);
    }

    // Function to retrieve the stored number
    function getStoredNumber() public view returns (uint256) {
        return storedNumber;
    }

    // Function to perform a calculation and assert a condition
    function performCalculation(uint256 _value) public pure returns (uint256) {
        uint256 result = _value * 2;
        
        // The assert statement checks for internal errors or invariant violations
        assert(result >= _value); // This will throw an error if the assertion fails
        
        return result;
    }

    // Function to withdraw funds from the contract, revert if not enough balance
    function withdraw(uint256 _amount) public {
        // Revert if the contract has insufficient balance for withdrawal
        if (address(this).balance < _amount) {
            revert("Insufficient balance for withdrawal");
        }

        payable(msg.sender).transfer(_amount);
    }

    // Function to receive Ether
    receive() external payable {}
}
