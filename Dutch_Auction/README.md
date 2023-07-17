# DutchAuction Contract

## Description

The `DutchAuction` contract implements a Dutch auction mechanism for the sale of a non-fungible token (NFT). The auction starts at a specified price and gradually decreases over a fixed duration. Participants can buy the NFT by sending the required payment within the auction duration. The auction can be canceled by the seller before it expires. After the auction ends, the seller can withdraw the NFT if it has not been sold.

### Events

The following events are emitted by the contract:

- `AuctionCancelled()`: Triggered when the auction is canceled by the seller.
- `Buy(address seller, address buyer, uint Price)`: Triggered when a buyer purchases the NFT.

### Contract Variables

- `seller` (address payable): The address of the seller who initiated the auction.
- `nft` (IERC721): An instance of the ERC721 contract representing the NFT.
- `nftId` (uint): The ID of the NFT being auctioned.
- `startingPrice` (uint): The initial price of the NFT.
- `startAt` (uint): The timestamp when the auction started.
- `expireAt` (uint): The timestamp when the auction will expire.
- `discountRate` (uint): The rate at which the price decreases over time.

### Constants

- `DURATION` (uint): The duration of the auction in seconds.

### Constructor

The constructor initializes the auction by setting the seller address, NFT contract instance, NFT ID, starting price, discount rate, start timestamp, and expiration timestamp. It also transfers the NFT from the seller to the contract.

#### Parameters

- `_nft` (address): The address of the ERC721 contract for the NFT.
- `_nftId` (uint): The ID of the NFT being auctioned.
- `_startingPrice` (uint): The initial price of the NFT.
- `_discountRate` (uint): The rate at which the price decreases over time.

### Functions

The `DutchAuction` contract provides the following functions:

#### `getPrice() → public view returns(uint)`

Returns the current price of the NFT based on the elapsed time since the start of the auction.

#### `buy() → payable external`

Allows a buyer to purchase the NFT by sending the required payment. Transfers the NFT to the buyer and refunds any excess payment.

#### `cancelAuction() → public`

Allows the seller to cancel the auction before it expires. Transfers the NFT back to the seller.

#### `withdrawNFT() → public`

Allows the seller to withdraw the NFT after the auction has expired and it has not been sold.

#### Fallback and Receive Functions

The contract includes fallback and receive functions that revert any attempt to send value to the contract.

## Usage

1. Deploy the `DutchAuction` contract, providing the address of the ERC721 contract, the ID of the NFT, the starting price, and the discount rate.
2. Participants can call the `buy` function and send the required payment to purchase the NFT within the auction duration.
3. The seller can cancel the auction by calling the `cancelAuction` function before it expires.
4. After the auction expires, the seller can withdraw the NFT by calling the `withdrawNFT` function if it has not been sold.

## License

This code is licensed under the MIT License.
