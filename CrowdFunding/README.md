# CrowdFunding Contract

## Description

The `CrowdFunding` contract enables the creation and management of crowdfunding campaigns. It allows users to launch new campaigns, pledge funds, claim funds, cancel campaigns, and request refunds. The contract is designed to work with an ERC20 token.

### Events

The following events are emitted by the contract:

- `Launch(uint index, address indexed creator, uint goal, uint startAt, uint endAt)`: Triggered when a new campaign is launched.
- `Pledge(uint indexed index, address indexed caller, uint amount)`: Triggered when a user pledges funds to a campaign.
- `UnPledge(uint indexed index, address indexed caller, uint amount)`: Triggered when a user withdraws pledged funds from a campaign.
- `Claim(uint index)`: Triggered when the campaign creator claims the pledged funds after the campaign ends.
- `Cancel(uint index)`: Triggered when the campaign creator cancels a campaign before it starts.
- `Refund(uint indexed index, address indexed caller, uint amount)`: Triggered when a user requests a refund for their pledged funds after the campaign ends.

### Contract Variables

- `token` (IERC20): An instance of the ERC20 token contract used for pledging and transferring funds.
- `count` (uint): The total number of campaigns launched so far.
- `campaigns` (mapping(uint => Campaign)): A mapping that stores information about each campaign.
- `pledgedAmount` (mapping(uint => mapping(address => uint))): A mapping that keeps track of the amount pledged by each user for each campaign.

### Structs

- `Campaign`: Stores information about a crowdfunding campaign, including the campaign creator, funding goal, amount pledged, start and end timestamps, and claim status.

### Constructor

The constructor initializes the `token` variable with the address of the ERC20 token contract.

#### Parameters

- `_token` (address): The address of the ERC20 token contract.

### Functions

The `CrowdFunding` contract provides the following functions:

#### `launch(uint _goal, uint _startAt, uint _endAt) → external`

Launches a new crowdfunding campaign.

##### Parameters

- `_goal` (uint): The funding goal of the campaign.
- `_startAt` (uint): The timestamp when the campaign will start.
- `_endAt` (uint): The timestamp when the campaign will end.

#### `pledge(uint _id, uint _amount) → external`

Pledges funds to a specific campaign.

##### Parameters

- `_id` (uint): The ID of the campaign.
- `_amount` (uint): The amount of funds to pledge.

#### `unPledge(uint _id, uint _amount) → external`

Withdraws pledged funds from a campaign.

##### Parameters

- `_id` (uint): The ID of the campaign.
- `_amount` (uint): The amount of funds to withdraw.

#### `cancel(uint _id) → external`

Cancels a campaign before it starts.

##### Parameters

- `_id` (uint): The ID of the campaign to cancel.

#### `claim(uint _id) → external`

Claims the pledged funds for a campaign after it ends.

##### Parameters

- `_id` (uint): The ID of the campaign to claim funds from.

#### `refund(uint _id) → external`

Requests a refund for pledged funds if the campaign fails to meet its funding goal.

##### Parameters

- `_id` (uint): The ID of the campaign to request a refund from.

## Usage

1. Deploy the `CrowdFunding` contract, providing the address of the ERC20 token contract.
2. Call the `launch` function to create a new campaign with the desired funding goal, start timestamp, and end timestamp.
3. Users can pledge funds to a campaign using the `pledge` function, specifying the campaign ID and the amount to pledge.
4. The campaign creator can claim the pledged funds using the `claim` function after the campaign ends, if the funding goal is met.
5. Users can request a refund using the `refund` function if the campaign fails to meet its funding goal.
6. The campaign creator can cancel the campaign before it starts using the `cancel` function.

## License

This code is licensed under the MIT License.
