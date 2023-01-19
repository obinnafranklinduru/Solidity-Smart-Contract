// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IERC721{
    function transferFrom(address from, address to, uint id) external;
    function ownerOf(uint id) external view returns (address owner);
}

contract DutchAuction{
    event AuctionCancelled();
    event Buy(address seller, address buyer, uint Price);

    address payable public immutable seller;
    IERC721 public immutable nft;
    uint public immutable nftId;

    uint public constant DURATION = 7 days;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expireAt;
    uint public immutable discountRate;

    constructor(address _nft, uint _nftId, uint _startingPrice, uint _discountRate)
    {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expireAt = block.timestamp + DURATION;

        // check if price of nft is always equal or greater than zero
        // to get the maximum amount of discount you need to multiply _discountRate by DURATION
        require(_startingPrice >= _discountRate * DURATION, "startingPrice is less than discount");

        nft = IERC721(_nft);
        nftId = _nftId;

        require(nft.ownerOf(nftId) == seller, "NFT has already been transferred");
        nft.transferFrom(seller, address(this), nftId);
    }

    function getPrice() public view returns(uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() payable external {
        require(block.timestamp < expireAt, "Auction has expired");
        require(nft.ownerOf(nftId) == address(this), "NFT has already been transferred");

        uint price = getPrice();
        require(msg.value >= price, "insufficient Fund");

        nft.transferFrom(address(this), msg.sender, nftId);
        uint refund = msg.value - price;
        if(refund > 0){
            payable(msg.sender).transfer(refund);
        }
        emit Buy(seller, msg.sender, price);
        selfdestruct(seller);
    }

    function cancelAuction() public {
        require(msg.sender == seller, "only seller can cancel the auction");
        require(block.timestamp < expireAt, "Auction has expired");

        require(nft.ownerOf(nftId) == address(this), "NFT has already been transferred");
        nft.transferFrom(address(this), seller, nftId);
        selfdestruct(seller);

        emit AuctionCancelled();
    }

    function withdrawNFT() public {
        require(msg.sender == seller, "Only the seller can withdraw the NFT");
        require(block.timestamp >= expireAt, "Auction has not expired yet");
        require(nft.ownerOf(nftId) == address(this), "NFT has been sold, cannot be withdrawn");

        nft.transferFrom(address(this), seller, nftId);
    }

    fallback() payable external {
        require(msg.value == 0, "Cannot send value to this contract");
    }
    receive() payable external {
        require(msg.value == 0, "Cannot send value to this contract");
    }
}