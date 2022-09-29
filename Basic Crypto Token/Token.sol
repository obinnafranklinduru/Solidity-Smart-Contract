// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

contract Token{
    address public minter;
    
    //to track the amount of address that mined
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    error insufficientBalance(uint requested, uint available);

    constructor() {
        minter = msg.sender;
    }

    //make new coins and send them to an address
    //only the owner can send these coins
    function mint(address reciever, uint amount) public {
        require(msg.sender == minter);
        balances[reciever] += amount;
    }

    function send(address reciever, uint amount) public {
        if(amount > balances[msg.sender]){
            revert insufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        }
        balances[msg.sender] -= amount;
        balances[reciever] += amount;

        emit Sent(msg.sender, reciever, amount);
    }
}