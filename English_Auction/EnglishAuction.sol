// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IERC721{
    function transferFrom(address from, address to, uint id) external;
}

contract EnglishAuction{
    event Start(uint StartedAt);
    event Bid(address indexed sender, uint indexed amount);
    event Withdraw(address indexed sender, uint indexed amount);
    event End(address HiggestBidder, uint HighestBid);

    IERC721 public immutable nft;
    uint public immutable nftId;

    address payable public immutable seller;
    address public highestBidder;

    uint public highestBid;
    uint32 public endAt;

    bool public started;
    bool public ended;
    mapping(address => uint) public bids;

    constructor(address _nft, uint _nftId, uint _startingBid){
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(!started, "Auction in progress");
        require(msg.sender == seller, "Only owner");

        started = true;
        endAt = uint32(block.timestamp + 7 days);
        nft.transferFrom(seller, address(this), nftId);

        emit Start(block.timestamp);
    }

    function bid() payable external {
        require(msg.sender != address(0), "Invalid Address");
        require(started, "Not Started");
        require(block.timestamp < endAt, "Auction has ended");
        require(msg.value > highestBid, "bid is less than current highestBid");
        
        if(highestBidder != address(0)){
            bids[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;

        emit Bid(msg.sender, msg.value);
    }

    function withdraw() payable external {
        require(ended, "Not ended");
        require(bids[msg.sender] > 0, "balance is zero");

        uint balance = bids[msg.sender];
        bids[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: balance}("");
        require(success, "Transaction failed");

        emit Withdraw(msg.sender, msg.value);
    }

    function end() payable external {
        require(started, "Not Started");
        require(!ended, "ended");
        require(block.timestamp >= endAt, "Auction has not ended");

        ended = true;
        if(highestBidder != address(0)){
            nft.transferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        } else {
           nft.transferFrom(address(this), seller, nftId); 
        }

        emit End(highestBidder, highestBid);
    }
}