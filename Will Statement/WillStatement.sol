// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

contract WillStatement{
    address owner;
    uint assets;
    bool decreased;

    constructor() payable {
        owner = msg.sender;
        assets = msg.value;
        decreased = false;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    modifier mustBeDecreased(){
        require(decreased == true);
        _;
    }

    address payable[] familyWallet;

    mapping(address => uint) inheritance;

    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        inheritance[wallet] = amount;
        familyWallet.push(wallet);
    }

    function payOut() private mustBeDecreased {
        for(uint i = 0; i < familyWallet.length; i++){
            familyWallet[i].transfer(inheritance[familyWallet[i]]);
        }
    }

    function isDecreased() external onlyOwner {
        decreased = true;
        payOut();
    }
}