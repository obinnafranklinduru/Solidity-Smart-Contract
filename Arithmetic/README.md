# Arithmetic Contract

## Description

The `Arithmetic` contract provides mathematical operations such as addition, subtraction, multiplication, division, and modulo for two integers.

## Functions

### `addition(int _numX, int _numY) → int`

Performs addition of two integers and returns the result.

#### Parameters

- `_numX` (int): The first integer operand.
- `_numY` (int): The second integer operand.

#### Returns

- `result` (int): The sum of `_numX` and `_numY`.

### `subtraction(int _numX, int _numY) → int`

Performs subtraction of two integers and returns the result.

#### Parameters

- `_numX` (int): The first integer operand.
- `_numY` (int): The second integer operand.

#### Returns

- `result` (int): The difference between `_numX` and `_numY`.

### `multiplication(int _numX, int _numY) → int`

Performs multiplication of two integers and returns the result.

#### Parameters

- `_numX` (int): The first integer operand.
- `_numY` (int): The second integer operand.

#### Returns

- `result` (int): The product of `_numX` and `_numY`.

### `division(int _numX, int _numY) → int`

Performs division of two integers and returns the result. Throws an error if division by zero is attempted.

#### Parameters

- `_numX` (int): The dividend.
- `_numY` (int): The divisor.

#### Returns

- `result` (int): The quotient of `_numX` divided by `_numY`.

#### Throws

- `Cannot divide by zero`: If `_numY` is zero.

### `modulo(int _numX, int _numY) → int`

Performs modulo operation on two integers and returns the result.

#### Parameters

- `_numX` (int): The first integer operand.
- `_numY` (int): The second integer operand.

#### Returns

- `result` (int): The remainder when `_numX` is divided by `_numY`.

## Usage

1. Deploy the `Arithmetic` contract on a Solidity-compatible Ethereum network.
2. Call the desired function with the appropriate arguments.

## License

This contract is licensed under the MIT License.
