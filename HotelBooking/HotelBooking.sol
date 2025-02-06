// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title HotelBooking
 * @dev Smart contract for booking hotel rooms with escrow payments and loyalty rewards.
 */
contract HotelBooking {
    struct Room {
        bool isBooked;
        address bookedBy;
        uint96 bookedPrice;
        uint256 bookingDeadline;
    }

    address public owner;
    uint256 public totalRooms;
    uint256 public defaultPrice; // Default price for each room and can be updated by the Hotel owner
    uint256 public totalReserved; // Tracks Ether reserved for potential refunds
    uint256 public constant REFUND_PERIOD = 1 days; 

    mapping(uint256 => Room) public rooms; // Track the room availability and status
    mapping(uint256 => uint256) private roomPrices; // Track the price for each room
    mapping(address => uint256) public loyaltyPoints;

    error OnlyOwner();
    error OverPayment();
    error RoomNotBooked();
    error InvalidRoomId();
    error NotYourBooking();
    error InvalidTotalRoom();
    error RoomAlreadyBooked();
    error InsufficientFunds();
    error InsufficientPayment();
    error BookingNotFinalized();
    error BookingDeadlinePassed();

    event RoomBooked(uint256 roomId, address bookedBy, uint256 price);
    event BookingCancelled(uint256 roomId, address cancelledBy, uint256 refundAmount);
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
        ///@notice if totalRooms == 100, valid _roomId is 0 to 99
        if (_roomId >= totalRooms) revert InvalidRoomId();
        if (rooms[_roomId].isBooked) revert RoomAlreadyBooked();
        _;
    }

    /**
     * @dev Contract constructor to initialize hotel rooms.
     * @param _totalRooms Total number of rooms available in the hotel.
     */
    constructor(uint256 _totalRooms) {
        if(_totalRooms == 0) revert InvalidTotalRoom();
        owner = msg.sender;
        totalRooms = _totalRooms;
        defaultPrice = 1 ether; // Default price 1 ETH
    }

    /**
     * @dev Returns the current price of a room, considering custom pricing.
     */
    function getRoomPrice(uint256 _roomId) public view returns (uint256) {
        ///@notice if totalRooms == 100, valid _roomId is 0 to 99
        if (_roomId >= totalRooms) revert InvalidRoomId();
        uint256 customPrice = roomPrices[_roomId];
        return customPrice != 0 ? customPrice : defaultPrice;
    }

    /**
     * @dev Function to book a room by paying the required amount.
     * @param _roomId ID of the room to be booked.
     */
    function bookRoom(uint256 _roomId) external payable roomAvailable(_roomId) {
        uint256 price = getRoomPrice(_roomId);
        if (msg.value != price) { 
            if (msg.value < price) revert InsufficientPayment();
            if (msg.value > price) revert OverPayment();
        }

        uint256 deadline = block.timestamp + REFUND_PERIOD;
        
        rooms[_roomId] = Room({
            isBooked: true,
            bookedBy: msg.sender,
            bookedPrice: uint96(price),
            bookingDeadline: deadline
        });
        
        totalReserved += price;
        loyaltyPoints[msg.sender] += 10;
        
        emit RoomBooked(_roomId, msg.sender, price);
        emit LoyaltyPointsEarned(msg.sender, 10);
    }

    /**
     * @dev Function to cancel a room booking and receive a refund.
     * @param _roomId ID of the room to be cancelled.
     */
    function cancelBooking(uint256 _roomId) external {
        Room storage room = rooms[_roomId];
        if (!room.isBooked) revert RoomNotBooked();
        if (room.bookedBy != msg.sender) revert NotYourBooking();
        if (block.timestamp > room.bookingDeadline) revert BookingDeadlinePassed();
        
        uint256 refundAmount = room.bookedPrice;
        delete rooms[_roomId];
        totalReserved -= refundAmount;
        
        payable(msg.sender).transfer(refundAmount);
        
        emit BookingCancelled(_roomId, msg.sender, refundAmount);
    }

    function finalizeBooking(uint256 _roomId) external onlyOwner {
        Room storage room = rooms[_roomId];
        if (!room.isBooked) revert RoomNotBooked();
        if (block.timestamp <= room.bookingDeadline) revert BookingNotFinalized();

        totalReserved -= room.bookedPrice;
        delete rooms[_roomId];
    }
    
    /**
     * @dev Function for the owner to update the price of a room.
     * @param _roomId ID of the room.
     * @param _newPrice New price for the room.
     */
    function updateRoomPrice(uint256 _roomId, uint256 _newPrice) external onlyOwner {
        roomPrices[_roomId] = _newPrice;
    }

    /**
     * @dev Function for the owner to update the default price for all rooms.
     * @param _newPrice New default price.
     */
    function updateDefaultPrice(uint256 _newPrice) external onlyOwner {
        defaultPrice = _newPrice;
    }
    
    /**
     * @dev Function for the owner to withdraw available funds from the contract.
     */
    function withdrawFunds() external onlyOwner {
        uint256 available = address(this).balance - totalReserved;
        if (available == 0) revert InsufficientFunds();
        payable(owner).transfer(available); // Only withdraw non-reserved funds
    }
}