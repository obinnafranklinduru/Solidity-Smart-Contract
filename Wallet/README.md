# Wallet contract
This contract allows an owner to deposit and withdraw ETH from a wallet. The contract also allows the owner to pause the contract, set a maximum transaction limit, and set a new owner.

## License
This contract is licensed under the MIT license.

## Variables
- owner: The owner of the contract.
- paused: A boolean value indicating whether the contract is paused or not.
- limitPerTransaction: The maximum amount that can be withdrawn in a single transaction.
Events
- Deposit: Emitted when ETH is deposited into the contract.
- Withdrawal: Emitted when ETH is withdrawn from the contract.

## Functions
### Constructor
The constructor sets the owner of the contract to the caller.

### deposit
The deposit function allows the owner to deposit ETH into the contract.

### withdraw
The withdraw function allows the owner to withdraw ETH from the contract. The amount withdrawn must be less than or equal to the limitPerTransaction variable and the contract's balance.

### addNewOwner
The addNewOwner function allows the owner to set a new owner for the contract.

### togglePaused
The togglePaused function allows the owner to pause or unpause the contract.

### getBalance
The getBalance function allows the owner to view the current balance of the contract.

### getLimitPerTransaction
The getLimitPerTransaction function allows the owner to view the current transaction limit for the contract.