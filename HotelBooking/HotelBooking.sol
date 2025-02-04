// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title HotelBooking
 * @dev Smart contract for booking hotel rooms with escrow payments and loyalty rewards.
 */
contract HotelBooking {
    struct Room {
        uint256 id;
        uint256 price;
        bool isBooked;
        address bookedBy;
    }

    address public owner;
    uint256 public totalRooms;
    mapping(uint256 => Room) public rooms;
    mapping(address => uint256) public loyaltyPoints;

    error OnlyOwner();
    error InvalidRoomId();
    error RoomAlreadyBooked();
    error OverPayment();
    error InsufficientPayment();
    error InsufficientFunds();
    error RoomNotBooked();
    error NotYourBooking();

    event RoomBooked(uint256 roomId, address bookedBy);
    event BookingCancelled(uint256 roomId, address cancelledBy);
    event LoyaltyPointsEarned(address user, uint256 points);

    /**
     * @dev Ensures only the contract owner can call certain functions.
     */
    modifier onlyOwner() {
        if (msg.sender != owner) revert OnlyOwner();
        _;
    }
    
    /**
     * @dev Ensures the room is available for booking.
     */
    modifier roomAvailable(uint256 _roomId) {
        if (_roomId >= totalRooms) revert InvalidRoomId();
        if (rooms[_roomId].isBooked) revert RoomAlreadyBooked();
        _;
    }
    
    /**
     * @dev Contract constructor to initialize hotel rooms.
     * @param _totalRooms Total number of rooms available in the hotel.
     */
    constructor(uint256 _totalRooms) {
        owner = msg.sender;
        totalRooms = _totalRooms;
        for (uint256 i = 1; i < _totalRooms; i++) {
            rooms[i] = Room(i, 1 ether, false, address(0)); // Default price 1 ETH
        }
    }

    /**
     * @dev Function to book a room by paying the required amount.
     * @param _roomId ID of the room to be booked.
     */
    function bookRoom(uint256 _roomId) external payable roomAvailable(_roomId) {
        if (msg.value < rooms[_roomId].price) revert InsufficientPayment();
        if (msg.value > rooms[_roomId].price) revert OverPayment();
        
        rooms[_roomId].isBooked = true;
        rooms[_roomId].bookedBy = msg.sender;
        loyaltyPoints[msg.sender] += 10;
        
        emit RoomBooked(_roomId, msg.sender);
        emit LoyaltyPointsEarned(msg.sender, 10);
    }

    /**
     * @dev Function to cancel a room booking and receive a refund.
     * @param _roomId ID of the room to be cancelled.
     */
    function cancelBooking(uint256 _roomId) external {
        if (!rooms[_roomId].isBooked) revert RoomNotBooked();
        if (rooms[_roomId].bookedBy != msg.sender) revert NotYourBooking();
        
        rooms[_roomId].isBooked = false;
        rooms[_roomId].bookedBy = address(0);
        payable(msg.sender).transfer(rooms[_roomId].price);
        
        emit BookingCancelled(_roomId, msg.sender);
    }
    
    /**
     * @dev Function for the owner to update the price of a room.
     * @param _roomId ID of the room.
     * @param _newPrice New price for the room.
     */
    function updateRoomPrice(uint256 _roomId, uint256 _newPrice) external onlyOwner {
        rooms[_roomId].price = _newPrice;
    }
    
    /**
     * @dev Function for the owner to withdraw all funds from the contract.
     */
    function withdrawFunds() external onlyOwner {
        if(address(this).balance == 0) revert InsufficientFunds();
        payable(owner).transfer(address(this).balance);
    }
}