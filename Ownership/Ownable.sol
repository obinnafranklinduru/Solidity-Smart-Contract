// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Ownable{
    address public owner;

    error OnlyOwner();

    modifier onlyOwner(){
        if(msg.sender != owner)
            revert OnlyOwner();
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setNewOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Invaild address");
        owner = _newOwner;
    }
}