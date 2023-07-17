# Ownable Contract

## Description

The `Ownable` contract provides basic ownership functionality, allowing a contract to have an owner and transferring ownership to another address.

### Events

- `OwnershipTransferred(address indexed previousOwner, address indexed newOwner)`: Triggered when ownership is transferred to a new address.
- `OwnershipRenounced(address indexed previousOwner)`: Triggered when ownership is renounced.

### Variables

- `owner` (address): The address of the contract owner.

### Modifiers

- `onlyOwner()`: Ensures that the caller is the owner of the contract.

### Functions

The `Ownable` contract provides the following functions:

#### `constructor()`

Initializes the contract by setting the deployer's address as the owner.

#### `transferOwnership(address _newOwner) external onlyOwner`

Transfers ownership of the contract to a new address.

#### `renounceOwnership() external onlyOwner`

Allows the current owner to renounce ownership of the contract.

## License

This code is licensed under the MIT License.
