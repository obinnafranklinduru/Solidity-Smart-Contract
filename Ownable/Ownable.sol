// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Ownable{
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event OwnershipRenounced(address indexed previousOwner);

    error OnlyOwner();
    modifier onlyOwner(){
        if(msg.sender != owner)
            revert OnlyOwner();
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Cannot transfer ownership to the zero address");
        require(_newOwner != address(this), "Cannot transfer ownership to the contract itself");
        require(_newOwner != msg.sender, "Cannot transfer ownership to oneself");
        owner = _newOwner;
        emit OwnershipTransferred(msg.sender, _newOwner);
    }

    function renounceOwnership() external onlyOwner {
        require(msg.sender == owner, "Only the current owner can renounce ownership");
        owner = address(0);
        emit OwnershipRenounced(msg.sender);
    }
}