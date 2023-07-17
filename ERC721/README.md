# ERC721 Contract

## Description

The `ERC721` contract implements the ERC721 token standard for non-fungible tokens (NFTs). It provides functions for token ownership, transfer, approval, and operator control. The contract also includes support for the ERC165 interface.

### Events

- `Transfer(address indexed from, address indexed to, uint indexed id)`: Triggered when a token is transferred from one address to another.
- `Approval(address indexed owner, address indexed spender, uint indexed id)`: Triggered when the approval of a token transfer is set.
- `ApprovalForAll(address indexed owner, address indexed operator, bool approved)`: Triggered when the approval for an operator is set.

### Variables

- `_ownerOf` (mapping(uint => address)): Mapping from token ID to owner address.
- `_balanceOf` (mapping(address => uint)): Mapping from owner address to token count.
- `_approvals` (mapping(uint => address)): Mapping from token ID to approved address.
- `isApprovedForAll` (mapping(address => mapping(address => bool))): Mapping from owner to operator approvals.

### Functions

The `ERC721` contract provides the following functions:

#### `supportsInterface(bytes4 interfaceId) → external pure returns (bool)`

Checks if the contract supports a specific interface based on its interface ID.

#### `ownerOf(uint id) → external view returns (address owner)`

Returns the owner of a specific token.

#### `balanceOf(address owner) → external view returns (uint)`

Returns the number of tokens owned by a specific address.

#### `setApprovalForAll(address operator, bool approved) → external`

Sets or revokes approval for an operator to manage all tokens on behalf of the sender.

#### `approve(address spender, uint id) → external`

Approves the transfer of a specific token to a specific address.

#### `getApproved(uint id) → external view returns (address)`

Returns the address approved to transfer a specific token.

#### `transferFrom(address from, address to, uint id) → public`

Transfers a specific token from one address to another.

#### `safeTransferFrom(address from, address to, uint id) → external`

Transfers a specific token from one address to another and calls the receiving contract's `onERC721Received` function.

#### `safeTransferFrom(address from, address to, uint id, bytes calldata data) → external`

Transfers a specific token from one address to another and calls the receiving contract's `onERC721Received` function with additional data.

#### `supportsInterface(bytes4 interfaceId) → external pure returns (bool)`

Checks if the contract supports a specific interface based on its interface ID.

#### `_mint(address to, uint id) → internal`

Mints a new token and assigns it to the specified owner.

#### `_burn(uint id) → internal`

Burns a specific token, removing it from circulation.

# IERC721 Interface

## Description

The `IERC721` interface defines the standard functions and events for an ERC721-compliant token.

### Functions

The `IERC721` interface defines the following functions:

#### `supportsInterface(bytes4 interfaceId) → external view returns (bool)`

Checks if the contract supports a specific interface based on its interface ID.

#### `ownerOf(uint tokenId) → external view returns (address owner)`

Returns the owner of a specific token.

#### `balanceOf(address owner) → external view returns (uint balance)`

Returns the number of tokens owned by a specific address.

#### `safeTransferFrom(address from, address to, uint tokenId) → external`

Transfers a specific token from one address to another and calls the receiving contract's `onERC721Received` function.

#### `safeTransferFrom(address from, address to, uint tokenId, bytes calldata data) → external`

Transfers a specific token from one address to another and calls the receiving contract's `onERC721Received` function with additional data.

#### `transferFrom(address from, address to, uint tokenId) → external`

Transfers a specific token from one address to another.

#### `approve(address to, uint tokenId) → external`

Approves the transfer of a specific token to a specific address.

#### `getApproved(uint tokenId) → external view returns (address operator)`

Returns the address approved to transfer a specific token.

#### `setApprovalForAll(address operator, bool approved) → external`

Sets or revokes approval for an operator to manage all tokens on behalf of the sender.

#### `isApprovedForAll(address owner, address operator) → external view returns (bool)`

Checks if an operator is approved to manage all tokens on behalf of the owner.

### Events

The `IERC721` interface defines the following events:

- `Transfer(address indexed from, address indexed to, uint indexed tokenId)`: Triggered when tokens are transferred from one address to another.
- `Approval(address indexed owner, address indexed spender, uint indexed tokenId)`: Triggered when the approval of a token transfer is set.
- `ApprovalForAll(address indexed owner, address indexed operator, bool approved)`: Triggered when the approval for an operator is set.

# IERC721Receiver Interface

## Description

The `IERC721Receiver` interface defines the function to be implemented by a contract to receive ERC721 tokens.

### Functions

The `IERC721Receiver` interface defines the following function:

#### `onERC721Received(address operator, address from, uint tokenId, bytes calldata data) → external returns (bytes4)`

Handles the receipt of an ERC721 token.

## License

This code is licensed under the MIT License.
