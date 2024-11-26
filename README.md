# SmartContract

This Solidity program demonstrates a simple smart contract with basic functionality such as storing and updating a number, performing calculations, and handling Ether transactions. It is designed to help you understand core Solidity concepts such as access control, event emission, and Ether management.

## Description

This smart contract allows the owner to store a number, retrieve the stored number, perform a simple calculation, and withdraw Ether from the contract. It also includes features like event emission to track updates to the stored number, and security checks using `require` and `assert` statements to ensure correct execution.

The contract is a starting point for those learning Solidity and can be easily expanded to include more advanced features.

## Getting Started

### Executing Program

To run this contract, you can use **Remix**, an online Solidity IDE. Follow these steps to get started:

1. Go to the [Remix website](https://remix.ethereum.org/).
2. In the left-hand sidebar, click the "+" icon to create a new file.
3. Save the file with a `.sol` extension (e.g., `SmartContract.sol`).
4. Copy and paste the following code into the file:

```solidity
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
```

### Compilation and Deployment

1. To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar of Remix.
2. Ensure the compiler version is set to `0.8.18` (or another compatible version), and click "Compile SmartContract.sol."
3. Once the contract is compiled, go to the "Deploy & Run Transactions" tab in Remix.
4. Select the `SmartContract` from the dropdown menu and click the "Deploy" button.

### Interacting with the Contract

1. **Store a Number** (Owner Only)
   - Only the owner of the contract can store a new number.
   - To store a number, use the `storeNumber` function. For example, calling `storeNumber(42)` will set the stored number to `42`.

2. **Get Stored Number**
   - Anyone can retrieve the current stored number by calling the `getStoredNumber` function.

3. **Perform Calculation**
   - Call `performCalculation` with a number to double it. For example, calling `performCalculation(5)` will return `10`.

4. **Withdraw Ether** (Owner Only)
   - The owner can withdraw Ether from the contract using the `withdraw` function. Ensure the contract has enough balance for the withdrawal.

5. **Send Ether to the Contract**
   - You can send Ether to the contract by simply transferring Ether to its address.
