# WillStatement Contract

## Description

The `WillStatement` contract allows the owner to set up inheritance allocations for a list of family wallets. The owner can distribute assets among the family wallets and finalize the inheritance allocations. Once the owner passes away (marked as "decreased"), the trusted party can trigger the payout to distribute the assets according to the finalized inheritance allocations.

### Variables

- `owner` (address): The address of the contract owner.
- `trustedParty` (address): The address of the trusted party who can trigger the payout.
- `familyWallet` (address payable[]): An array of family wallet addresses.
- `assets` (uint): The total assets available for inheritance.
- `timeLock` (uint): The timestamp representing the time lock period for the payout.
- `paidOut` (bool): Indicates whether the payout has been distributed.
- `decreased` (bool): Indicates whether the owner has passed away.
- `finalized` (bool): Indicates whether the inheritance allocations have been finalized.
- `inheritance` (mapping): Mapping of family wallet addresses to their inheritance amount.

### Modifiers

- `onlyOwner()`: Ensures that the caller is the owner or the trusted party.
- `mustBeDecreased()`: Ensures that the owner has passed away.
- `notFinalize()`: Ensures that the inheritance allocations have not been finalized.
- `validAddress(address wallet)`: Ensures that the provided wallet address is valid.

### Functions

The `WillStatement` contract provides the following functions:

#### `constructor() payable`

Initializes the contract by setting the deployer's address as the owner and accepting an initial deposit of assets.

#### `setInheritance(address payable wallet, uint amount) public onlyOwner notFinalize validAddress(wallet)`

Sets the inheritance amount for a family wallet.

#### `incementInheritance(address payable wallet, uint amount) payable public onlyOwner notFinalize validAddress(wallet)`

Increases the inheritance amount for a family wallet.

#### `decementInheritance(address payable wallet, uint amount) payable public onlyOwner notFinalize validAddress(wallet)`

Decreases the inheritance amount for a family wallet.

#### `removeInheritance(address wallet) public onlyOwner notFinalize validAddress(wallet)`

Removes the inheritance allocation for a family wallet.

#### `finalizeInheritance() public onlyOwner notFinalize`

Finalizes the inheritance allocations.

#### `setTimeLock(uint _timeLock) public onlyOwner`

Sets the time lock period for the payout.

#### `payOut() private mustBeDecreased`

Distributes the assets to the family wallets according to the finalized inheritance allocations.

#### `setTrustedParty(address _trustedParty) public onlyOwner`

Sets the trusted party address.

#### `isDecreased() payable external onlyOwner`

Marks the owner as "decreased" and triggers the payout.

#### `getRemainingAssets() external view returns(uint)`

Returns the remaining assets available for inheritance.

#### `getTotalAssets() external view returns(uint)`

Returns the total assets held by the contract.

#### `receive() payable external`

Fallback function to receive additional assets.

## License

This code is licensed under the MIT License.
