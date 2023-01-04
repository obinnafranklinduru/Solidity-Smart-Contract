// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Wallet{
    address payable public owner;
    bool public paused;
    uint256 public limitPerTransaction  = 1 ether;

    event Withdrawal(address receiver, uint256 amount, uint256 blockTime);
    event Deposit(address sender, uint256 amount, uint256 blockTime);

    error OnlyOwner(address NotOwner);
    modifier onlyOwner(){
        if(msg.sender != owner){
            revert OnlyOwner(msg.sender);
        }
        _;
    }

    constructor() payable {
        require(msg.sender != address(0), "InvalidAddress");
        owner = payable(msg.sender);
    }

    function deposit() payable external onlyOwner{
        require(msg.value > 0, "Insufficient Balance");
        (bool sent, ) = address(this).call{value: msg.value}("");
        require(sent, "Not successful");

        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(uint256 _amount) payable external onlyOwner{
        require(!paused, "Contract is paused");
        require(_amount > 0, "Invalid amount");
        require(_amount <= limitPerTransaction, "Withdrawal exceeds limit per transaction");
        require(_amount <= address(this).balance, "amount greater than balance");
        (bool sent, ) = payable(msg.sender).call{value: _amount}("");
        require(sent, "Not successful");

        emit Withdrawal(msg.sender, _amount, block.timestamp);
    }

    function addNewOwner(address payable _newOwner) external onlyOwner {
        require(_newOwner != address(0), "InvalidAddress");
        require(_newOwner != address(this), "InvalidAddress");
        owner = _newOwner;
    }

    function togglePaused() external onlyOwner{
       paused = !paused; 
    }
    function getBalance() external view returns(uint256 balance) {
        balance = address(this).balance;
    }
    function getLimitPerTransaction() external view returns(uint256 limit) {
        limit = limitPerTransaction;
    }

    receive() payable external{}
    fallback() payable external{}
}