# ERC20 Contract

## Description

The `ERC20` contract implements the ERC20 token standard. It allows for the creation and management of ERC20-compliant tokens. The contract keeps track of token balances for each address, allows token transfers between addresses, and provides functions for token approval and allowance.

### Contract Variables

- `totalSupply` (uint256): The total supply of tokens.
- `decimals` (uint256): The number of decimal places for token values.
- `name` (string): The name of the token.
- `symbol` (string): The symbol of the token.
- `balanceOf` (mapping(address => uint256)): A mapping of token balances for each address.
- `allowance` (mapping(address => mapping(address => uint256))): A mapping of approved allowances for each address.

### Constructor

The constructor initializes the token by setting the name and symbol.

#### Parameters

- `_name` (string): The name of the token.
- `_symbol` (string): The symbol of the token.

### Functions

The `ERC20` contract provides the following functions:

#### `transfer(address _to, uint256 _value) → external returns (bool success)`

Transfers a specified amount of tokens from the sender's address to the recipient's address.

#### `transferFrom(address _from, address _to, uint256 _value) → external returns (bool success)`

Transfers a specified amount of tokens from the owner's address to another address if approved by the owner.

#### `approve(address _spender, uint256 _value) → external returns (bool success)`

Approves a specified address to spend a specified amount of tokens on behalf of the owner.

#### `mint(uint256 _value) → external`

Mints new tokens and adds them to the balance of the sender.

#### `burn(uint256 _value) → external`

Burns a specified amount of tokens from the sender's balance.

# IERC20 Interface

## Description

The `IERC20` interface defines the standard functions and events for an ERC20-compliant token.

### Functions

The `IERC20` interface defines the following functions:

#### `totalSupply() → external view returns (uint256)`

Returns the total supply of tokens.

#### `balanceOf(address _owner) → external view returns (uint256 balance)`

Returns the token balance of a specified address.

#### `transfer(address _to, uint256 _value) → external returns (bool success)`

Transfers a specified amount of tokens from the sender's address to the recipient's address.

#### `transferFrom(address _from, address _to, uint256 _value) → external returns (bool success)`

Transfers a specified amount of tokens from the owner's address to another address if approved by the owner.

#### `approve(address _spender, uint256 _value) → external returns (bool success)`

Approves a specified address to spend a specified amount of tokens on behalf of the owner.

#### `allowance(address _owner, address _spender) → external view returns (uint256 remaining)`

Returns the remaining allowance of tokens that a spender is allowed to spend on behalf of an owner.

### Events

The `IERC20` interface defines the following events:

- `Transfer(address indexed _from, address indexed _to, uint256 _value)`: Triggered when tokens are transferred from one address to another.
- `Approval(address indexed _owner, address indexed _spender, uint256 _value)`: Triggered when the allowance of a spender is approved by the owner.

## License

This code is licensed under the MIT License.
