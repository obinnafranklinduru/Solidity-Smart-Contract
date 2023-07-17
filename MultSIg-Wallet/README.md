# MultiSigWallet Contract

## Description

The `MultiSigWallet` contract implements a multi-signature wallet that requires multiple owners to confirm and execute transactions. It provides functions for managing owners, submitting transactions, confirming transactions, executing transactions, revoking confirmations, and setting the number of required confirmations. The contract also includes support for emergency withdrawal and pausing functionality.

### Events

- `Deposit(address indexed sender, uint amount, uint balance)`: Triggered when funds are deposited into the wallet.
- `Transfer(address indexed sender, address indexed receiver, uint amount)`: Triggered when funds are transferred from the wallet.
- `ConfirmTransaction(address indexed owner, uint indexed txIndex)`: Triggered when an owner confirms a transaction.
- `RevokeConfirmation(address indexed owner, uint indexed txIndex)`: Triggered when an owner revokes their confirmation for a transaction.
- `ExecuteTransaction(address indexed owner, uint indexed txIndex)`: Triggered when a confirmed transaction is executed.
- `SubmitTransaction(address indexed owner, uint indexed txIndex, address indexed to, uint value, bytes data)`: Triggered when a transaction is submitted to the wallet.
- `SetNumConfirmationsRequired(uint indexed numConfirmationsRequired)`: Triggered when the number of required confirmations is set.
- `Pause()`: Triggered when the wallet is paused.
- `Unpause()`: Triggered when the wallet is unpaused.
- `Recovery(address indexed oldAccount, address indexed newAccount)`: Triggered when an owner is changed.

### Variables

- `isOwner` (mapping(address => bool)): Mapping from address to owner status.
- `isConfirmed` (mapping(uint256 => mapping(address => bool))): Mapping from transaction index to mapping from owner address to confirmation status.
- `owners` (address[]): Array of owner addresses.
- `transactions` (Transaction[]): Array of Transaction structs representing submitted transactions.
- `numConfirmationsRequired` (uint256): Number of required confirmations for a transaction to be executed.
- `emergencyWithdrawalTime` (uint256): Unix timestamp indicating the time when the emergency withdrawal period starts.
- `paused` (bool): Flag indicating whether the wallet is paused.

### Structs

- `Transaction`: Represents a submitted transaction.
  - `to` (address payable): The address of the recipient of the transaction.
  - `value` (uint): The amount of ether to transfer.
  - `data` (bytes): Additional data to include in the transaction.
  - `executed` (bool): Flag indicating whether the transaction has been executed.
  - `numConfirmations` (uint256): Number of confirmations received for the transaction.

### Modifiers

- `onlyOwner()`: Ensures that the caller is an owner of the wallet.
- `txExists(uint256 _txIndex)`: Ensures that the specified transaction exists.
- `notConfirmed(uint256 _txIndex)`: Ensures that the caller has not confirmed the specified transaction.
- `notExecuted(uint256 _txIndex)`: Ensures that the specified transaction has not been executed.
- `whenNotPaused()`: Ensures that the wallet is not paused.

### Functions

The `MultiSigWallet` contract provides the following functions:

#### `constructor(address[] memory _owners, uint256 _numConfirmationsRequired)`

Creates a new instance of the contract and initializes the initial owners and number of required confirmations.

#### `addOwner(address _account) external onlyOwner`

Allows an existing owner to add a new owner to the wallet.

#### `removeOwner(address _account) external onlyOwner`

Allows an existing owner to remove an existing owner from the wallet.

#### `submitTransaction(address payable _to, bytes memory _data) payable public whenNotPaused onlyOwner`

Allows an owner to submit a transaction to be executed by the wallet.

#### `confirmTransaction(uint _txIndex) public onlyOwner txExists(_txIndex) notExecuted(_txIndex) notConfirmed(_txIndex)`

Allows an owner to confirm a transaction.

#### `executeTransaction(uint _txIndex) public onlyOwner txExists(_txIndex) whenNotPaused notExecuted(_txIndex)`

Allows an owner to execute a confirmed transaction.

#### `revokeConfirmation(uint _txIndex) public onlyOwner txExists(_txIndex) notExecuted(_txIndex)`

Allows an owner to revoke their confirmation for a transaction.

#### `pause() external onlyOwner`

Allows an owner to pause the wallet.

#### `unpause() external onlyOwner`

Allows an owner to unpause the wallet.

#### `setEmergencyWithdrawalTime() public onlyOwner`

Sets the emergency withdrawal time.

#### `emergencyWithdrawal(address payable _to) external`

Performs an emergency withdrawal of all the funds stored in the contract.

#### `setNumConfirmationsRequired(uint256 _numConfirmationsRequired) external onlyOwner`

Sets the number of required confirmations for a transaction to be executed.

#### `changeOwner(address _oldOwner, address _newOwner) external onlyOwner`

Changes the ownership of the wallet from an old owner to a new owner.

#### `totalSupply() external view returns (uint256)`

Returns the total balance of the wallet.

#### `getOwners() public view returns (address[] memory)`

Returns an array of owner addresses.

#### `getTransactionCount() public view returns (uint)`

Returns the number of submitted transactions.

#### `getTransaction(uint _txIndex) public view returns (address to, uint value, bytes memory data, bool executed, uint256 numConfirmations)`

Returns the details of a submitted transaction.

#### `receive() payable external`

Fallback function that accepts ether deposits.

## License

This code is licensed under the MIT License.
