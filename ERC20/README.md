# ERC20
This contract is an implementation of the ERC20 token standard. It allows users to transfer and manage their tokens, and provides functions for approving and transferring tokens on behalf of other users.

## Constructor(string memory _name, string memory _symbol)
This function is the constructor for the ERC20 contract. It is called when the contract is deployed and allows the contract owner to set the name and symbol properties of the token. The _name parameter represents the name of the token, and the _symbol parameter represents the symbol of the token.

The name and symbol properties are important because they allow users to identify the token and distinguish it from other tokens. They are typically displayed in wallets and exchanges, and are used to reference the token in transactions and other interactions.

By providing the name and symbol as arguments to the constructor, the contract owner can customize these properties to match the desired branding and identity of the token.

## Properties
- totalSupply: The total number of tokens in circulation.
- decimals: The number of decimal places that the tokens have.
- name: The name of the token.
- symbol: The symbol of the token.
- balanceOf: A mapping from addresses to token balances.
- allowance: A mapping from addresses to mappings of approved token amounts that other users are allowed to transfer on behalf of the owner.
## Functions
### transfer(address _to, uint256 _value)
This function allows a user to transfer _value tokens to _to. It reduces the sender's balance by _value and increases the recipient's balance by _value.

### transferFrom(address _from, address _to, uint256 _value)
This function allows a user to transfer _value tokens from _from to _to on behalf of the owner of _from. It reduces the owner's balance by _value, reduces the allowance of the caller for _from by _value, and increases the recipient's balance by _value.

### approve(address _spender, uint256 _value)
This function allows the owner of a token balance to approve _value tokens to be transferred by _spender. It increases the allowance of _spender for the owner by _value.

### mint(uint256 _value)
This function allows the contract owner to mint new tokens and add them to their own balance. It increases the totalSupply by _value and the contract owner's balance by _value.

### burn(uint256 _value)
This function allows the contract owner to burn their own tokens and reduce the totalSupply. It reduces the contract owner's balance by _value and the totalSupply by _value.

### Events
- Transfer: Emitted when tokens are transferred from one address to another.
- Approval: Emitted when an approval for transferring tokens on behalf of the owner is granted or changed.