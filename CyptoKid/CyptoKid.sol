// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CyptoKid {
    address public owner;

    error OnlyOwner();
    error ValidAddress();

    event Deposit(address sender, uint amount , uint time);
    event Withdrawal(address reciever, uint amount , uint time);

    struct Kid{
        address payable walletAddress;
        string firstName;
        string lastName;
        uint releasedDate;
        uint amount;
        bool withdrawn;
    }
    Kid[] public kids;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        if(msg.sender != owner){
            revert OnlyOwner();
        }
        _;
    }
    modifier validAddress(address _walletAddress){
        if(_walletAddress == address(0)){
            revert ValidAddress();
        }
        _;
    }

    function addKid(address payable _walletAddress, string memory _firstName, string memory _lastName)
    public onlyOwner validAddress(_walletAddress)
    {
        require(_walletAddress != owner, "owner cannot be a child.");

        for(uint i; i < kids.length; i++){
            require(kids[i].walletAddress != _walletAddress, "Address is already in kids array");
        }
        // compute the hash of the _firstName and _lastName strings
        bytes32 firstNameHash = keccak256(abi.encodePacked(_firstName));
        bytes32 lastNameHash = keccak256(abi.encodePacked(_lastName));
        // compute the hash of an empty string
        bytes32 emptyStringHash = keccak256(abi.encodePacked(""));
        // check if the hashes are equal to the empty string hash
        require(firstNameHash != emptyStringHash, "first name cannot be empty");
        require(lastNameHash != emptyStringHash, "last name cannot be empty");

        Kid memory kid;
        kid.walletAddress = _walletAddress;
        kid.firstName = _firstName;
        kid.lastName = _lastName;
        kid.releasedDate = block.timestamp + (16 * (356 * 1 days));
        
        kids.push(kid);
    }
    function getIndex(address _walletAddress) private view returns(uint) {
        for(uint i; i < kids.length; i++){
            if(kids[i].walletAddress == _walletAddress){
                return i;
            }
        }
        return 409;
    }
    // deposit funds into the account designated for a kid's education 
   function deposit(address _walletAddress)
    payable public validAddress(_walletAddress)
    {
        require(_walletAddress != owner, "owner cannot be a child.");
        require(msg.value > 0, "Insufficient balance");
        uint i = getIndex(_walletAddress);
        require(kids[i].walletAddress == _walletAddress, "Address is not in kids array");
        kids[i].amount += msg.value;
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }
    function balance() public view returns(uint){
        uint i = getIndex(msg.sender);
        if(msg.sender != kids[i].walletAddress){
            revert ValidAddress();
        }
        return kids[i].amount;
    }
    // child check if they are able to withdraw
    function availabeToWithdraw(address _walletAddress) view public returns(bool){
        uint i = getIndex(_walletAddress);
        if(block.timestamp > kids[i].releasedDate){
            return true;
        }else{
            return false;
        }
    }
    // withdraw
    function withdraw(address payable _walletAddress) public payable validAddress(_walletAddress) {
        uint i = getIndex(_walletAddress);

        require(kids[i].amount > 0, "Insufficient Balance");
        require(msg.sender == kids[i].walletAddress, "only owner of the account");
        require(block.timestamp > kids[i].releasedDate, "wait for the release time");
        require(!kids[i].withdrawn, "funds have already been withdrawn");

        kids[i].amount -= kids[i].amount;
        _walletAddress.transfer(kids[i].amount);
        kids[i].withdrawn = true;

        emit Withdrawal(msg.sender, kids[i].amount, block.timestamp);
    }
}