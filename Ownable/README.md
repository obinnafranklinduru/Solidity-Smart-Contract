# Ownable contract
The Ownable contract is a base contract that allows a contract to have an owner. It includes functions for transferring and renouncing ownership, as well as an onlyOwner modifier that can be used to restrict access to certain functions to the contract owner.

## Functions
### constructor
The constructor is called when the contract is deployed and sets the contract owner to the address of the deploying user.

### transferOwnership
The transferOwnership function allows the contract owner to transfer ownership of the contract to another address. It requires that the new owner is not the zero address or the contract itself, and that the caller is not transferring ownership to themselves.

### renounceOwnership
The renounceOwnership function allows the contract owner to renounce their ownership of the contract. It requires that the caller is the current owner of the contract.

## Events
### OwnershipTransferred
The OwnershipTransferred event is emitted when ownership of the contract is transferred to a new owner. It includes the previous owner and the new owner as indexed parameters.

### OwnershipRenounced
The OwnershipRenounced event is emitted when the contract owner renounces their ownership of the contract. It includes the previous owner as an indexed parameter.

## Modifiers
### onlyOwner
The onlyOwner modifier is applied to functions to restrict access to only the contract owner. If the caller is not the contract owner, the transaction will be reverted.

## Here's a brief summary of what the Ownable contract does:

- It has an owner variable that stores the address of the current owner of the contract.
- It has an OwnershipTransferred event that is emitted whenever ownership of the contract is transferred from one address to another.
- It has an OwnershipRenounced event that is emitted whenever the current owner renounces their ownership of the contract.
- It has an onlyOwner modifier that can be applied to functions to ensure that only the current owner can call those functions.
- It has a transferOwnership function that allows the current owner to transfer ownership of the contract to a new address. This function includes require statements to ensure that the new owner is not the zero address, the contract itself, or the current owner.
- It has a renounceOwnership function that allows the current owner to renounce their ownership of the contract. This function includes a require statement to ensure that only the current owner can renounce their ownership.