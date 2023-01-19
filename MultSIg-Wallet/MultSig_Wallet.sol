//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract MultiSigWallet{
    event Deposit(address indexed sender, uint amount, uint balance);
    event Transfer(address indexed sender, address indexed receiver, uint amount);
    event ConfirmTransaction(address indexed owner, uint indexed txIndex);
    event RevokeConfirmation(address indexed owner, uint indexed txIndex);
    event ExecuteTransaction(address indexed owner, uint indexed txIndex);
    event SubmitTransaction(
        address indexed owner,
        uint indexed txIndex,
        address indexed to,
        uint value,
        bytes data
    );
    event SetNumConfirmationsRequired(uint indexed numConfirmationsRequired);
    event Pause();
    event Unpause();
    event Recovery(address indexed oldAccount, address indexed newAccount);

    mapping(address => bool) public isOwner;
    mapping(uint256 => mapping(address => bool)) public isConfirmed;

    address[] public owners;
    Transaction[] public transactions;

    uint256 public numConfirmationsRequired;
    uint256 public emergencyWithdrawalTime;
    bool paused;

    struct Transaction {
        address payable to;
        uint value;
        bytes data;
        bool executed;
        uint256 numConfirmations;
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender] = true, "Avaiable to Owners");
        _;
    }
    modifier txExists(uint256 _txIndex) {
        require(_txIndex < transactions.length, "Tx does not exist");
        _;
    }
    modifier notConfirmed(uint256 _txIndex) {
        require(!isConfirmed[_txIndex][msg.sender], "Tx already comfirmed");
        _;
    }
    modifier notExecuted(uint256 _txIndex) {
        require(!transactions[_txIndex].executed, "Tx already executed");
        _;
    }
    modifier whenNotPaused() {
        require(!paused, "Wallet is paused");
        _;
    }

    /**
     * constructor function is used to create a new instance of the contract and set the initial owners and number of required confirmations.
     * 
     * @param _owners: An array of addresses representing the initial owners of the wallet
     * @param _numConfirmationsRequired: The number of required confirmations for a transaction to be executed
     */
    constructor(address[] memory _owners, uint256 _numConfirmationsRequired){
        require(_owners.length > 0, "Invalid number of member");
        require(
            _numConfirmationsRequired > 0 &&
                _numConfirmationsRequired < _owners.length,
            "invalid number of required confirmations"
        );
        
        for(uint256 i; i < _owners.length; i++){
            address owner = _owners[i];
            require(owner != address(0), "Invalid Address");
            require(!isOwner[owner], "owner is not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }
        numConfirmationsRequired = _numConfirmationsRequired;
    }

    /**
     * addOwner: This function allows an existing owner to add a new owner to the wallet.
     * 
     * @param _account: The address of the new owner
     * 
     * Requirements
     *  The caller must be an existing owner of the wallet
     *  The new owner's address must not already be an owner of the wallet
     */
    function addOwner(address _account) external onlyOwner {
        require(!isOwner[_account], "Address already exist");
        require(_account != address(0), "Invalid Address");
        isOwner[_account] = true;
        owners.push(_account);
        // numConfirmations is incremented when new members are added.
        numConfirmationsRequired++;
    }

    /**
     * removeOwner: This function allows an existing owner to remove an existing owner from the wallet.
     * 
     * @param _account: The address of the owner to remove
     * 
     * Requirements
     *  The caller must be an existing owner of the wallet
     *  The owner to remove must be an existing owner of the wallet
     *  The wallet must have more than one owner
     */
    function removeOwner(address _account) external onlyOwner {
        bool findMember;
        uint256 indexedMember;
        require(owners.length > 1, "Cannot remove all owner of the wallet");
        for(uint256 i = 0; i < owners.length; i++){
            if(_account == owners[i]){
                findMember = true;
                indexedMember = i;
                break;
            }
        }
        require(findMember, "Not an owner of the wallet");
        isOwner[owners[indexedMember]] = false;
        owners[indexedMember] = owners[owners.length - 1];
        owners.pop();
        // numConfirmations is decremented when new members are removed.
        numConfirmationsRequired--;
    }

    /**
     * submitTransaction: This function allows an owner to submit a transaction to be executed by the wallet.
     * 
     * @param _to: The address of the recipient of the transaction
     * @param _data: Additional data to include in the transaction
     * 
     * Requirements
     *  The caller must be an owner of the wallet
     *  The wallet must not be paused
     */
    function submitTransaction(address payable _to, bytes memory _data) 
    payable 
    public
    whenNotPaused 
    onlyOwner 
    {
        uint txIndex = (transactions.length - 1);
        require(msg.value > 0, "insufficient balance");
        
        transactions.push(
            Transaction({
                to: _to,
                value: msg.value,
                data: _data,
                executed: false,
                numConfirmations: 0
            })
        );

        emit SubmitTransaction(msg.sender, txIndex, _to, msg.value, _data);
    }

    /**
     * confirmTransaction: This function allows an owner to confirm a transaction.
     * @param _txIndex: The index of the transaction to confirm
     * 
     * Requirements
     *  The caller must be an owner of the wallet
     *  The transaction must not already have been confirmed by the caller
     *  The transaction must not already have been executed.
     *  The transaction must exist
     *  The wallet must not be paused
     */
    function confirmTransaction(uint _txIndex) 
    public 
    onlyOwner 
    txExists(_txIndex) 
    notExecuted(_txIndex) 
    notConfirmed(_txIndex) 
    {
        Transaction storage transaction = transactions[_txIndex];
        transaction.numConfirmations += 1;
        isConfirmed[_txIndex][msg.sender] = true;

        emit ConfirmTransaction(msg.sender, _txIndex);
    }

    /**
     * executeTransaction: This function allows an owner to execute a confirmed transaction.
     * @param _txIndex: The index of the transaction to confirm
     * 
     * Requirements
     *  The caller must be an owner of the wallet
     *  The transaction must not already have been executed
     *  The transaction must exist
     *  The wallet must not be paused
     *  The numConfirmations greater or equal to numConfirmationsRequired
     */
    function executeTransaction(uint _txIndex) 
    public 
    onlyOwner 
    txExists(_txIndex)
    whenNotPaused 
    notExecuted(_txIndex) 
    {
        Transaction storage transaction = transactions[_txIndex];

        require(
            transaction.numConfirmations >= numConfirmationsRequired,
            "cannot execute tx"
        );

        transaction.executed = true;

        (bool success, ) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success, "tx failed");

        emit ExecuteTransaction(msg.sender, _txIndex);
        emit Transfer(msg.sender, transaction.to, transaction.value);
    }

    /**
     * revokeConfirmation: This function allows an owner to revoke 
     *  their confirmation for a transaction. 
     *  If a transaction does not have enough confirmations after one is revoked, 
     *  it cannot be executed.
     * 
     * @param _txIndex: The index of the transaction to confirm
     * 
     * Requirements
     *  The caller must be an owner of the wallet
     *  The transaction must not already have been confirmed by the caller
     *  The transaction must not already have been executed.
     *  The transaction must exist
     */
    function revokeConfirmation(uint _txIndex) 
    public 
    onlyOwner 
    txExists(_txIndex) 
    notExecuted(_txIndex) 
    {
        Transaction storage transaction = transactions[_txIndex];

        require(isConfirmed[_txIndex][msg.sender], "tx not confirmed");

        transaction.numConfirmations -= 1;
        isConfirmed[_txIndex][msg.sender] = false;

        emit RevokeConfirmation(msg.sender, _txIndex);
    }

    // This function allows an owner to pause the wallet
    function pause() external onlyOwner {
        require(!paused, "Wallet is already paused");
        paused = true;
        emit Pause();
    }

    // This function allows an owner to unpause the wallet
    function unpause() external onlyOwner {
        require(paused, "Wallet is not paused");
        paused = false;
        emit Unpause();
    }

    function setEmergencyWithdrawalTime() public onlyOwner {
        emergencyWithdrawalTime = block.timestamp + 24 hours;
    }

    // The emergencyWithdrawal function in this smart contract allows an owner of the contract 
    // to perform a withdrawal of all the funds stored in the contract in case of an emergency.

    // The user has to setEmergencyWithdrawalTime which will automatically 
    // add 24 hours to the current block.timestamp,
    // then the owner has to wait for the time to elapse.
    function emergencyWithdrawal(address payable _to) external {
        require(isOwner[msg.sender], "Only an owner can perform an emergency withdrawal");
        require(address(this).balance > 0, "Insufficient Balance");

        require(block.timestamp >= emergencyWithdrawalTime, "Emergency withdrawal period has not started");
        _to.transfer(address(this).balance);
    }

    function setNumConfirmationsRequired(uint256 _numConfirmationsRequired) external onlyOwner {
        require(_numConfirmationsRequired > 0 && _numConfirmationsRequired <= owners.length, "Invalid number of required confirmations");
        numConfirmationsRequired = _numConfirmationsRequired;

        emit SetNumConfirmationsRequired(_numConfirmationsRequired);
    }

    function changeOwner(address _oldOwner, address _newOwner) external onlyOwner {
        // Check that the old owner is an existing owner of the wallet
        require(isOwner[_oldOwner], "Old owner is not an owner of the wallet");

        // Check that the new owner is not an existing owner of the wallet
        require(!isOwner[_newOwner], "New owner is already an owner of the wallet");

        // Check that the new owner is not the zero address
        require(_newOwner != address(0), "Invalid new owner address");

        // Update the mapping to reflect the change in ownership
        isOwner[_oldOwner] = false;
        isOwner[_newOwner] = true;

        // Update the owners array to reflect the change in ownership
        for (uint256 i = 0; i < owners.length; i++) {
            if (owners[i] == _oldOwner) {
                owners[i] = _newOwner;
                break;
            }
        }

        emit Recovery(_oldOwner, _newOwner);
    }

    function totalSupply() external view returns (uint256){
        return (address(this)).balance;
    }

    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    function getTransactionCount() public view returns (uint) {
        return transactions.length;
    }

    function getTransaction(
        uint _txIndex
    )
        public
        view
        returns (
            address to,
            uint value,
            bytes memory data,
            bool executed,
            uint256 numConfirmations
        )
    {
        Transaction storage transaction = transactions[_txIndex];

        return (
            transaction.to,
            transaction.value,
            transaction.data,
            transaction.executed,
            transaction.numConfirmations
        );
    }

    receive() payable external {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }
}