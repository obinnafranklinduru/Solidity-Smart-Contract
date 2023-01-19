// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract WillStatement{
    address public immutable owner;
    address public trustedParty;
    address payable[] familyWallet;

    uint public  assets;
    uint public timeLock;

    bool public paidOut;
    bool public decreased;
    bool public finalized;
    mapping(address => uint) inheritance;

    modifier onlyOwner(){
        require(msg.sender == owner || msg.sender == trustedParty);
        _;
    }
    modifier mustBeDecreased(){
        require(decreased == true);
        _;
    }

    constructor() payable {
        owner = msg.sender;
        assets = msg.value;
    }

    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        require(!finalized, "nheritance allocations have been finalized, cannot be modified");
        require(wallet != address(0), "Invalid Address");
        require(amount <= assets, "Amount cannot be greater than total assets");
        require(inheritance[wallet] == 0, "Wallet already exists in Family Wallet list");
        inheritance[wallet] = amount;
        familyWallet.push(wallet);
    }

    function finalizeInheritance() public onlyOwner{
        require(finalized == false, "Inheritance allocations have been finalized, cannot be modified");
        finalized = true;
    }

    function setTimeLock(uint _timeLock) public onlyOwner {
        require(_timeLock > 0);
        timeLock = _timeLock;
    }

    function payOut() private mustBeDecreased {
        require(paidOut == false);
        require(decreased == true);
        require(finalized == true);
        require(address(this).balance >= assets);
        require(block.timestamp > timeLock);
        for(uint i = 0; i < familyWallet.length; i++){
            familyWallet[i].transfer(inheritance[familyWallet[i]]);
        }
        paidOut = true;
    }

    function setTrustedParty(address _trustedParty) public onlyOwner {
        trustedParty = _trustedParty;
    }

    function isDecreased() payable external onlyOwner {
        decreased = true;
        payOut();
    }
}