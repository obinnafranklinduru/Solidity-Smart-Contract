# Dutch Auction Smart Contract
This smart contract is a Dutch auction contract, which allows the seller to auction off a non-fungible token (NFT) at a price is reduced until a buyer found. The contract uses a Dutch auction mechanism, where the price of the NFT starts high and gradually decreases over time until the auction is won or the auction expires.

## Features
- The contract is designed to work with any ERC721 compliant NFT contract.
- The contract uses a Dutch auction mechanism, where the price of the NFT starts high and gradually decreases over time until the auction is won or the auction expires.
- The contract has a built-in mechanism to prevent the seller from transferring the NFT to another address before the auction has ended.
- The contract has a built-in mechanism to prevent the seller from calling the selfdestruct function before the auction has expired.
- The contract has a built-in mechanism to handle refunds in case the auction is cancelled.
- The contract has a fallback function that reverts if called with a value greater than 0, to prevent accidental overpayments.
- The contract has a cancelAuction() function that allows the seller to cancel the auction before the expiration, only allow the seller to call it.
- The contract has a function to retrieve the current price of the NFT, which takes into account the time elapsed since the start of the auction and the discount rate.
- The contract has a function allows the owner of the NFT to withdraw it from the auction if the auction was not successful.

## Functions
### create: This function is used to create a new auction for an NFT. It requires the address of the ERC721 contract and the ID of the NFT to be auctioned off, as well as the starting price and the discount rate. It can only be called by the seller.

### getPrice: This function is used to retrieve the current price of the NFT, which takes into account the time elapsed since the start of the auction and the discount rate.

### buy: This function is used to make a bid on the NFT. It requires that the auction has not expired, the NFT has not been transferred to another address, and that the bid is equal to or greater than the current price of the NFT.

### cancelAuction: This function is used to cancel the auction before the expiration. It requires that the auction has not expired, and can only be called by the seller.

### fallback: This function is the default function that is called when the contract is sent ether. It prevents accidental overpayments by reverting if called with a value greater than 0.

### receive: This function is the default function that is called when the contract receives ether. It prevents accidental overpayments by reverting if called with a value greater than 0.

### withdrawNFT(): This function allows the owner of the NFT to withdraw it from the auction if the auction was not successful.

## Events
- AuctionCancelled: This event is emitted when the auction is cancelled.
- Buy: This event is emitted when the nft is bought.
