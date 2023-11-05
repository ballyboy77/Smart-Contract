// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    address public owner;
    mapping (address => uint) public balances;

    event Deposit(address indexed account, uint amount);
    event Withdrawal(address indexed account, uint amount);

    constructor() {
        owner = msg.sender;
    }

    // This is a custom modifier called onlyOwner.
    //  Modifiers are used to add conditions to functions.
    //  In this case, it checks if the caller of the function is the owner of the contract.
    //  If not, it reverts the transaction with the provided error message.
    modifier onlyOwner(){
        require(msg.sender==owner,"Only the owner can call this function");
        _;
        
    }
    // It's marked as external to indicate that it can be called from outside the contract. 
    // The payable keyword allows the function to receive Ether with the transaction
    function deposit() external payable  {
        require(msg.value>0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit  Deposit(msg.sender,msg.value);
    }

    // It checks if the user has a sufficient balance, deducts the specified amount 
    // from their balance, transfers the Ether to the user's address,
    //  and emits a Withdrawal event to log the withdrawal.
    function withdraw(uint amount) external{
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable (msg.sender).transfer(amount);
        emit  Withdrawal(msg.sender, amount);

    
    }
    // This function lets users check their account balance. 
    // It's marked as view since it only reads data without modifying it, 
    // and it returns the balance of the caller.
    function CheckBalance() external view returns(uint ) {
        return balances[msg.sender];
    }





    

}