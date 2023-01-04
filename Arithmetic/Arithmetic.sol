// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Arithmetic{

    function addition(int _numX, int _numY) external pure returns(int){
        return _numX + _numY;
    }

    function subtraction(int _numX, int _numY) external pure returns(int){
        return _numX - _numY;
    }

    function multiplication(int _numX, int _numY) external pure returns(int){
        return _numX * _numY;
    }

    function division(int _numX, int _numY) external pure returns(int) {
        require(_numY != 0, "Cannot divide by zero");
        return _numX / _numY;
    }

    function modulo(int _numX, int _numY) external pure returns(int){
        return _numX % _numY;
    }
}