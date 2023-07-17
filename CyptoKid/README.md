# CyptoKid Contract

## Description

The `CyptoKid` contract allows the creation of accounts for children's education savings. The contract owner can add kids' accounts, deposit funds into the accounts, and allow the kids to withdraw funds after a specific release date. Each kid account is associated with an address, first name, last name, release date, and amount.

### Events

The following events are emitted by the contract:

- `Deposit(address sender, uint amount, uint time)`: Triggered when funds are deposited into a kid's account.
- `Withdrawal(address receiver, uint amount, uint time)`: Triggered when funds are withdrawn from a kid's account.

### Contract Variables

- `owner` (address): The address of the contract owner.
- `kids` (array of Kid): An array that stores information about each kid account.

### Structs

- `Kid`: Stores information about a kid's account, including the wallet address, first name, last name, release date, amount, and withdrawal status.

### Constructor

The constructor sets the contract owner to the address of the deployer.

### Modifiers

- `onlyOwner`: Ensures that only the contract owner can execute the function.
- `validAddress`: Checks if the provided address is valid (not the zero address).

### Functions

The `CyptoKid` contract provides the following functions:

#### `addKid(address payable _walletAddress, string memory _firstName, string memory _lastName) → public onlyOwner validAddress(_walletAddress)`

Adds a new kid's account to the contract.

##### Parameters

- `_walletAddress` (address payable): The wallet address associated with the kid's account.
- `_firstName` (string): The first name of the kid.
- `_lastName` (string): The last name of the kid.

#### `deposit(address _walletAddress) → payable public validAddress(_walletAddress)`

Deposits funds into a kid's account.

##### Parameters

- `_walletAddress` (address): The wallet address associated with the kid's account.

#### `balance() → public view returns (uint)`

Returns the current balance of the caller's kid account.

#### `availableToWithdraw(address _walletAddress) → view public returns (bool)`

Checks if a kid's account is eligible for fund withdrawal based on the release date.

##### Parameters

- `_walletAddress` (address): The wallet address associated with the kid's account.

##### Returns

- `bool`: `true` if the kid's account is eligible for withdrawal, `false` otherwise.

#### `withdraw(address payable _walletAddress) → public payable validAddress(_walletAddress)`

Withdraws funds from a kid's account.

##### Parameters

- `_walletAddress` (address payable): The wallet address associated with the kid's account.

## Usage

1. Deploy the `CyptoKid` contract.
2. Call the `addKid` function to create a new kid's account, providing the kid's wallet address, first name, and last name.
3. Deposit funds into a kid's account using the `deposit` function, specifying the kid's wallet address.
4. Check the balance of a kid's account using the `balance` function.
5. Verify if a kid's account is eligible for withdrawal using the `availableToWithdraw` function.
6. Withdraw funds from a kid's account using the `withdraw` function, providing the kid's wallet address.

## License

This code is licensed under the MIT License.
