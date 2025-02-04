# Flash Loan Arbitrage System

## Overview

This project demonstrates a simple implementation of flash loans and arbitrage strategies using Solidity smart contracts. It includes:

1. **Flash Loan Provider**: A contract that allows users to borrow tokens temporarily.
2. **Arbitrage Executor**: A contract that uses flash loans to exploit price differences between markets.
3. **ERC20 Token**: A mock token for testing the system.

---

## Contracts

### 1. `Token.sol`

A basic ERC20 token implementation for testing purposes.

**Features**:

- Standard ERC20 functions (`transfer`, `transferFrom`, `approve`)
- Custom errors for gas efficiency
- Immutable token details (`name`, `symbol`, `decimals`)

---

### 2. `FlashLoan.sol`

A flash loan provider contract.

**Features**:

- Lends tokens with a 0.1% fee
- Ensures repayment within the same transaction
- Uses `ReentrancyGuard` for security
- Custom errors for better gas efficiency

**Key Functions**:

- `flashloan(uint256 amount)`: Initiates a flash loan.
- Security checks:
  - Ensures loan is repaid with fee
  - Prevents reentrancy attacks

---

### 3. `FlashLoanReceiver.sol`

An example contract that uses flash loans for arbitrage.

**Features**:

- Simulates arbitrage between two mock exchanges
- Calculates profit after fees
- Distributes profit to the owner
- Custom errors for failure cases

**Key Functions**:

- `receiveToken(address token, uint256 amount)`: Callback for flash loan execution.
- `executeFlashloan(uint256 amount)`: Initiates a flash loan and arbitrage.

---

## How It Works

### Workflow

1. **Deploy Contracts**:

   - Deploy `Token` contract.
   - Deploy `FlashLoan` with the token address.
   - Deploy `FlashLoanReceiver` with the flash loan pool address.

2. **Fund the Pool**:

   - Transfer tokens to the `FlashLoan` contract to provide liquidity.

3. **Execute Arbitrage**:

   - Call `executeFlashloan(amount)` on the `FlashLoanReceiver` contract.

4. **Transaction Flow**:
   - Borrow tokens via flash loan.
   - Simulate selling tokens at a higher price.
   - Simulate buying tokens at a lower price.
   - Repay the loan with fee.
   - Distribute profit to the owner.

---

## Example Transactions

### 1. Deploy Contracts

```javascript
const Token = await ethers.getContractFactory("Token");
const token = await Token.deploy("Test Token", "TTK", 1000000);

const FlashLoan = await ethers.getContractFactory("FlashLoan");
const flashLoan = await FlashLoan.deploy(token.address);

const FlashLoanReceiver = await ethers.getContractFactory("FlashLoanReceiver");
const receiver = await FlashLoanReceiver.deploy(flashLoan.address);
```

### 2. Fund the Pool

```javascript
await token.transfer(flashLoan.address, ethers.utils.parseEther("100000"));
```

### 3. Execute Arbitrage

```javascript
await receiver.executeFlashloan(ethers.utils.parseEther("1000"));
```

---

## Security Considerations

### Risks

1. **Reentrancy Attacks**:
   - Mitigated by `ReentrancyGuard`.
2. **Price Slippage**:
   - Real-world implementation must account for market volatility.
3. **Failed Transactions**:
   - Ensure proper error handling in arbitrage logic.

### Best Practices

- Use `require` statements for critical checks.
- Implement custom errors for gas efficiency.
- Use verified libraries like OpenZeppelin.
