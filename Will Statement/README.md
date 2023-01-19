# WillStatement Smart Contract
This smart contract allows the owner to set up a will statement on the Ethereum blockchain. The contract is designed to distribute assets to a specified set of beneficiaries (family members) upon the owner's death. You will also need a small amount of Ether to deploy the contract. Once deployed, the contract can be interacted with using the functions described below. The contract has several features including:

- Setting inheritance amounts for specific beneficiaries
- Incrementing or decrementing inheritance amounts for specific beneficiaries
- Removing inheritance amounts for specific beneficiaries
- Finalizing the inheritance allocations
- Setting a time lock for the pay out of assets

## Contract Variables
- owner: The address of the contract owner
- trustedParty: An address that is trusted by the owner to manage the contract in the event of the owner's death
familyWallet: An array of addresses that represent the beneficiaries of the contract
- assets: The total amount of assets in the contract
- timeLock: The timestamp at which the assets will be paid out to the beneficiaries
- paidOut: A boolean that is set to true once the assets have been paid out to the beneficiaries
- decreased: A boolean that is set to true once the owner has passed away
- finalized: A boolean that is set to true once the inheritance allocations have been finalized
- inheritance: A mapping that keeps track of the inheritance amounts for each beneficiary

## Contract Modifiers
- onlyOwner: This modifier ensures that only the owner or the trustedParty can execute a function
- mustBeDecreased: This modifier ensures that a function can only be executed once the owner has passed away
- notFinalize: This modifier ensures that a function can only be executed before the inheritance allocations have been finalized
- validAddress: This modifier ensures that a provided address is not the zero address and is not the owner's address

## Contract Functions
### constructor()
The constructor function is called when the contract is deployed. It requires that the contract is deployed with a positive amount of Ether. The address of the deployer is set as the owner and trustedParty of the contract. The value of the deployment is set as the assets of the contract.

### setInheritance(address payable wallet, uint amount)
This function allows the owner to set an inheritance amount for a specific beneficiary. The function requires that the provided address is a valid address, that the inheritance amount is less than or equal to the total assets, and that the provided address does not already have an inheritance amount set.

### incrementInheritance(address payable wallet, uint amount)
This function allows the owner to increment an existing inheritance amount for a specific beneficiary. The function requires that the provided address is a valid address, that the increment amount is a positive value and less than or equal to the total assets.

### decementInheritance(address payable wallet, uint amount)
This function allows the owner to decrement an existing inheritance amount for a specific beneficiary. The function requires that the provided address is a valid address, that the decrement amount is a positive value and less than the existing inheritance amount of the provided address.

### removeInheritance(address wallet)
This function allows the owner to remove an existing inheritance amount for a specific beneficiary. The function requires that the provided address is a valid address.

### finalizeInheritance()
This function allows the owner to finalize the inheritance allocations. The function requires that all assets have been distributed and that there is at least one beneficiary in the contract.

### setTimeLock(uint _timeLock)
This function allows the owner to set a timestamp for the pay out of assets to the beneficiaries. The function requires that the provided time lock is a positive value.

### payOut()
This function distributes the assets to the beneficiaries. It can only be executed by the trustedParty, after the owner has passed away, after the inheritance allocations have been finalized, and after the time lock has passed. It requires that the contract has enough balance to pay out the assets.

### setTrustedParty(address _trustedParty)
This function allows the owner to set a new trustedParty address. This address will be able to execute certain functions on the contract such as payOut() in the event of the owner's death. The function requires that the msg.sender is the current owner of the contract.

### isDecreased()
This function is used to notify the contract that the owner has passed away. It can only be executed by the owner. Once executed, the decreased variable is set to true and the payOut() function is executed.

### getRemainingAssets()
This function allows anyone to view the remaining assets in the contract. It returns the value of the assets variable.

### getTotalAssets()
This function allows anyone to view the total assets in the contract, including the remaining assets and the assets that have been distributed to the beneficiaries. It returns the balance of the contract.

### receive()
This function is the fallback function of the contract and it allows anyone to send ether to the contract. This function will be triggered automatically when ether is sent to the contract. The function requires that the sent amount is greater than 0, it increases the assets variable by the amount sent to the contract.

## Requirements
- This contract requires that the Solidity compiler version 0.8.9 or higher is used.
- The contract is under MIT license

## Security Considerations
- Keep the owner and trustedParty addresses secure, as they have the ability to modify the contract
- Make sure to set the time lock for pay out of assets to a suitable time after the owner's passing
- Be careful when modifying the inheritance allocations, as once the contract is finalized, the allocations cannot be modified.
- Make sure that the contract has enough balance for the pay out of assets.