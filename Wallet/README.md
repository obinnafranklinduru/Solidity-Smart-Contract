# Wallet Contract

## Description

The `Wallet` contract allows the owner to deposit and withdraw funds from the contract. The contract includes a withdrawal limit per transaction and the ability to pause or resume contract functionality.

### Events

- `Withdrawal(address receiver, uint256 amount, uint256 blockTime)`: Triggered when a withdrawal is made from the contract.
- `Deposit(address sender, uint256 amount, uint256 blockTime)`: Triggered when a deposit is made to the contract.

### Variables

- `owner` (address payable): The address of the owner of the wallet.
- `paused` (bool): Indicates whether the contract is paused or not.
- `limitPerTransaction` (uint256): The maximum amount that can be withdrawn in a single transaction.

### Modifiers

- `onlyOwner()`: Ensures that the caller is the owner of the wallet.

### Functions

The `Wallet` contract provides the following functions:

#### `constructor() payable`

Initializes the contract by setting the deployer's address as the owner.

#### `deposit() payable external onlyOwner`

Allows the owner to deposit funds into the contract.

#### `withdraw(uint256 _amount) payable external onlyOwner`

Allows the owner to withdraw funds from the contract.

#### `addNewOwner(address payable _newOwner) external onlyOwner`

Allows the owner to add a new owner to the wallet.

#### `togglePaused() external onlyOwner`

Allows the owner to pause or resume the contract.

#### `getBalance() external view returns(uint256 balance)`

Returns the balance of the contract.

#### `getLimitPerTransaction() external view returns(uint256 limit)`

Returns the withdrawal limit per transaction.

#### `receive() payable external`

Fallback function to receive funds.

#### `fallback() payable external`

Fallback function to receive funds.

## License

This code is licensed under the MIT License.
