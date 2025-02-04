# Hotel Booking Smart Contract

## Overview

This smart contract allows users to book hotel rooms in a decentralized manner, ensuring secure escrow payments, automated refunds, and a loyalty rewards system.

## Features

- Immutable on-chain **hotel room booking** records
- **Escrow-based payments** to prevent fraud
- **Loyalty points** earned on booking
- **Booking cancellations** with automatic refunds
- **Custom error handling** for gas efficiency
- **Owner-controlled room pricing**
- **Secure fund withdrawal** by the contract owner

## Functions

### 1. `bookRoom(uint256 _roomId)`

Allows a user to book a room by sending the required amount.

- **Requires:**
  - Room must be available
  - Sufficient Ether must be sent
- **Emits Events:**
  - `RoomBooked`
  - `LoyaltyPointsEarned`

### 2. `cancelBooking(uint256 _roomId)`

Allows a user to cancel their booking and receive a refund.

- **Requires:**
  - The room must be booked
  - Caller must be the one who booked the room
- **Emits Event:**
  - `BookingCancelled`

### 3. `updateRoomPrice(uint256 _roomId, uint256 _newPrice)`

Allows the owner to change the price of a room.

- **Requires:**
  - Caller must be the contract owner

### 4. `withdrawFunds()`

Allows the owner to withdraw all contract funds.

- **Requires:**
  - Caller must be the contract owner

## Events

- `RoomBooked(uint256 roomId, address bookedBy)` – Triggers when a room is successfully booked.
- `BookingCancelled(uint256 roomId, address cancelledBy)` – Triggers when a booking is canceled.
- `LoyaltyPointsEarned(address user, uint256 points)` – Triggers when a user earns loyalty points.

## Custom Errors

- `OnlyOwner()` – Triggered if a non-owner tries to execute owner-only functions.
- `InvalidRoomId()` – Triggered if an invalid room ID is provided.
- `RoomAlreadyBooked()` – Triggered if the room is already booked.
- `InsufficientPayment()` – Triggered if the payment is above the required amount.
- `InsufficientPayment()` – Triggered if the payment is below the required amount.
- `InsufficientFunds()` – Triggered if there is no balance for the owner to withraw.
- `RoomNotBooked()` – Triggered if a cancellation is attempted on an unbooked room.
- `NotYourBooking()` – Triggered if a user tries to cancel another person's booking.

## Deployment

To deploy this contract (Using EtherJs):

```solidity
const HotelBooking = await ethers.getContractFactory("HotelBooking");
const hotel = await HotelBooking.deploy(10); // Initialize with 10 rooms
await hotel.deployed();
console.log("HotelBooking deployed to:", hotel.address);
```
