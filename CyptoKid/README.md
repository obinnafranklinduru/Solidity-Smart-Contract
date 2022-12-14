# Cypto kid

CrytoKid is a kind of will-statement contract. Think of it as a contract wherein a parent agrees to set aside funds in an account for each of their children as soon as the kid is born, and the child will be permitted access to the funds after the child reaches the age of 16.

The code is a Solidity smart contract for a cryptocurrency education savings account for children. The contract has a CyptoKid struct that stores information about a child, including their wallet address, first and last name, release date, amount, and a boolean indicating whether the funds have been withdrawn.

The contract has a constructor that sets the owner of the contract to the contract creator. There are two modifiers that check the validity of a wallet address and whether the caller is the contract owner, respectively.

The addKid function allows the contract owner to add a new child to the contract. It requires a valid wallet address, and checks that the wallet address is not the owner's address and that it is not already in the kids array. It also checks that the child's first and last names are not empty by computing their keccak256 hash and comparing it to the hash of an empty string. If all checks pass, it adds the child to the kids array.

The deposit function allows anyone to deposit funds into a child's account. It requires a valid wallet address, and checks that the wallet address is not the owner's address and that it is in the kids array. It also checks that the value being deposited is greater than 0. If all checks pass, it updates the child's balance and emits a Deposit event.

The balance function returns the balance of the account associated with the caller's wallet address.

The availabeToWithdraw function checks if a child is able to withdraw their funds by comparing the current block timestamp to the child's release date.

The withdraw function allows the child associated with the provided wallet address to withdraw their funds if they are available to withdraw, the balance is greater than 0, and the funds have not been withdrawn before. If all checks pass, it transfers the funds to the child's wallet, updates the withdrawn flag, and emits a Withdrawal event.