# EnglishAuction Contract

## Description

The `EnglishAuction` contract implements an English auction mechanism for the sale of a non-fungible token (NFT). The auction starts at a specified starting bid and allows participants to place higher bids within a specified duration. The highest bidder at the end of the auction wins the NFT. Participants can withdraw their bids if they are not the highest bidder.

### Events

The following events are emitted by the contract:

- `Start(uint StartedAt)`: Triggered when the auction starts.
- `Bid(address indexed sender, uint indexed amount)`: Triggered when a participant places a bid.
- `Withdraw(address indexed sender, uint indexed amount)`: Triggered when a participant withdraws their bid.
- `End(address HighestBidder, uint HighestBid)`: Triggered when the auction ends.

### Contract Variables

- `nft` (IERC721): An instance of the ERC721 contract representing the NFT.
- `nftId` (uint): The ID of the NFT being auctioned.
- `seller` (address payable): The address of the seller who initiated the auction.
- `highestBidder` (address): The address of the current highest bidder.
- `highestBid` (uint): The amount of the highest bid.
- `endAt` (uint32): The timestamp when the auction will end.
- `started` (bool): Indicates if the auction has started.
- `ended` (bool): Indicates if the auction has ended.
- `bids` (mapping(address => uint)): A mapping that stores the bids of participants.

### Constructor

The constructor initializes the auction by setting the NFT contract instance, the ID of the NFT, the starting bid, and the seller address. It transfers the NFT from the seller to the contract.

#### Parameters

- `_nft` (address): The address of the ERC721 contract for the NFT.
- `_nftId` (uint): The ID of the NFT being auctioned.
- `_startingBid` (uint): The starting bid for the auction.

### Functions

The `EnglishAuction` contract provides the following functions:

#### `start() → external`

Starts the auction. Only the seller can call this function.

#### `bid() → payable external`

Places a bid in the auction. Participants must send a higher value than the current highest bid.

#### `withdraw() → payable external`

Allows a participant to withdraw their bid if they are not the highest bidder.

#### `end() → payable external`

Ends the auction and transfers the NFT to the highest bidder. If no bids were placed, the NFT is returned to the seller.

## Usage

1. Deploy the `EnglishAuction` contract, providing the address of the ERC721 contract, the ID of the NFT, and the starting bid.
2. Call the `start` function to start the auction. Only the seller can start the auction.
3. Participants can call the `bid` function and send a higher value than the current highest bid to place a bid.
4. Participants can withdraw their bids by calling the `withdraw` function.
5. After the auction ends, call the `end` function to transfer the NFT to the highest bidder and the bid amount to the seller.

## License

This code is licensed under the MIT License.
