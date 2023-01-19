// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ERC20/ERC20.sol";

contract CrowdFunding {
    event Launch(uint index, address indexed creator, uint goal, uint startAt, uint endAt);
    event Pledge(uint indexed index, address indexed caller, uint amount);
    event UnPledge(uint indexed index, address indexed caller, uint amount);
    event Claim(uint index);
    event Cancel(uint index);
    event Refund(uint indexed index, address indexed caller, uint amount);

    IERC20 public immutable token;
    uint public count;

    mapping(uint => Campaign) public campaigns;
    mapping(uint => mapping(address => uint)) public pledgedAmount;

    struct Campaign{
        address creator;
        uint goal;
        uint pledged;
        uint32 startAt;
        uint32 endAt;
        bool claimed;
    }

    constructor(address _token){
        token = IERC20(_token);
    }

    function launch(uint _goal, uint _startAt, uint _endAt) external 
    {
        require(_startAt >= block.timestamp, "startAt < now");
        require(_endAt >= _startAt, "endAt < startAt");
        require(_endAt <= block.timestamp + 90 days, "endAt > max duration");

        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: uint32(_startAt),
            endAt: uint32(_endAt),
            claimed: false
        });

        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }

    function pledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "Not Started");
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledged += _amount;
        pledgedAmount[_id][msg.sender] += _amount;
        token.transferFrom(msg.sender, address(this), _amount);

        emit Pledge(_id, msg.sender, _amount);
    }

    function unPledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -= _amount;
        token.transfer(msg.sender, _amount);

        emit UnPledge(_id, msg.sender, _amount);
    }

    function cancel(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(msg.sender == campaign.creator, "Not Creator");
        require(block.timestamp < campaign.startAt, "Started");

        delete campaigns[_id];
        emit Cancel(_id);
    }

    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(msg.sender == campaign.creator, "Not Creator");
        require(block.timestamp > campaign.endAt, "ended");
        require(campaign.pledged >= campaign.goal, "pledge < goal");
        require(!campaign.claimed, "Claimed");

        campaign.claimed = true;
        token.transfer(msg.sender, campaign.pledged);

        emit Claim(_id);
    }

    function refund(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "ended");
        require(campaign.pledged < campaign.goal, "pledge < goal");

        uint balance = pledgedAmount[_id][msg.sender];
        pledgedAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender, balance);

        emit Refund(_id, msg.sender, balance);
    }
}