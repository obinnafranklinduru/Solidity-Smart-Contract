# MultiSigWallet
This is a Solidity implementation of a multi-signature wallet contract. It allows a group of owners to jointly manage a shared wallet and requires a certain number of confirmations from owners before a transaction can be executed.

### Features
- Add and remove wallet owners
- Deposit funds into the wallet
- Submit transactions to be confirmed and executed by the owners
- Confirm and revoke transaction confirmations
- Set the required number of confirmations for transactions
- Pause and unpause the wallet to prevent transactions from being submitted or executed
- Recover the wallet in the event that it becomes stranded or otherwise unable to function

### Events
- Deposit: Emitted when funds are deposited into the wallet.
- ConfirmTransaction: Emitted when an owner confirms a transaction.
- RevokeConfirmation: Emitted when an owner revokes their confirmation of a transaction.
- ExecuteTransaction: Emitted when a transaction is executed by the wallet.
- SubmitTransaction: Emitted when a transaction is submitted to the wallet.
- SetNumConfirmationsRequired: Emitted when the required number of confirmations is changed.
- Pause: Emitted when the wallet is paused.
- Unpause: Emitted when the wallet is unpaused.
- Recovery: Emitted when an owner recovers their funds to a new address.

### Functions
#### constructor(address[] memory _owners, uint256 _numConfirmationsRequired)
The constructor is called when the contract is deployed and sets the initial list of owners and the number of confirmations required for a transaction to be executed.

#### addOwner(address _account)
This function allows an existing owner to add a new owner to the wallet.

#### removeOwner(address _account)
This function allows an existing owner to remove another owner from the wallet. It is not possible to remove the last owner.

#### submitTransaction(address payable _to, string memory _data)
This function allows an owner to submit a new transaction to the wallet. The transaction includes the recipient address, the value (in wei) to be sent, and an optional data field.

#### confirmTransaction(uint256 _txIndex)
This function allows an owner to confirm a transaction. Once enough confirmations have been received, the transaction can be executed.

#### revokeConfirmation(uint256 _txIndex)
This function allows an owner to revoke their confirmation for a transaction. If a transaction does not have enough confirmations after one is revoked, it cannot be executed.

#### executeTransaction(uint256 _txIndex)
This function allows an owner to execute a confirmed transaction.

#### setNumConfirmationsRequired(uint256 _newNumConfirmationsRequired)
This function allows an owner to change the number of confirmations required for a transaction to be executed.

#### pause()
This function allows an owner to pause the wallet, which prevents any transactions from being submitted or executed.

#### unpause()
This function allows an owner to unpause the wallet, allowing transactions to be submitted and executed again.

#### changeOwner(address _oldAccount, address _newAccount)
This function allows an owner to change the owner of the contract to a new Ethereum account in the event that the old owner's account is compromised or lost.

#### function emergencyWithdrawal(address payable _to)
This function allows any owner to call it and withdraw the funds from the wallet, as long as the wallet is not empty. This can be useful in cases where the wallet becomes stranded or otherwise unable to function, as it allows the owners to recover their funds.