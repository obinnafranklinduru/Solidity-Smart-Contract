# CryptoKid
CryptoKid is a smart contract that manages funds for children's education. The contract allows parents to deposit funds into a child's account and allows children to withdraw the funds once they reach the age of majority.

## Functions
###  addKid(address _walletAddress, string _firstName, string _lastName)
This function adds a new child to the contract and sets their wallet address, first name, and last name. It also sets the date at which the child will be able to withdraw their funds.

### deposit(address _walletAddress)
This function allows parents to deposit funds into a child's account.

### balance()
This function returns the balance of the caller's account.

### availableToWithdraw(address _walletAddress)
This function returns true if the child associated with the provided wallet address is able to withdraw their funds, and false otherwise.

### withdraw(address _walletAddress)
This function allows a child to withdraw their funds once they are able to do so.

### transferOwnership(address _newOwner)
This function allows the owner of the contract to transfer ownership to another address.

### renounceOwnership()
This function allows the owner of the contract to renounce their ownership of the contract.

## Events
The CyptoKid contract includes several events that can be used to track important information about the contract.

### Deposit
The Deposit event is triggered whenever funds are deposited into a child's education account. It includes the following parameters:
- sender: The address of the user that made the deposit
- amount: The amount of the deposit
- time: The timestamp of the block in which the deposit was made

### Withdrawal
The Withdrawal event is triggered whenever a child withdraws funds from their education account. It includes the following parameters:
- receiver: The address of the child that withdrew the funds
- amount: The amount of the withdrawal
- time: The timestamp of the block in which the withdrawal was made