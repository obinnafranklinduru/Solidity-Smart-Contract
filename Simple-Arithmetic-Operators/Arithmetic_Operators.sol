// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Arithmetic_Operators{
    address payable public user;
    uint private userFee;
    uint public price = 5 wei;

    modifier checkUser(){
        bool userStatue;
        if(userFee == price){
            userStatue = true;
        }else if(userFee > price){
            revert("Money is too high, Use 5 wei to deploy");
        }else if(userFee < price){
            revert("Money is too low, Use 5 wei to deploy");
        }

        require(userStatue == true, "Not a user here, Kindly Use 5 wei to deploy");
        _;
    }

    constructor() payable {
        user = payable(msg.sender);
        userFee = msg.value;
    }

    function addition(uint _numX, uint _numY) public view checkUser returns(uint){
        return _numX + _numY;
    }

    function subtraction(uint _numX, uint _numY) public view checkUser returns(uint){
        return _numX - _numY;
    }

    function division(uint _numX, uint _numY) public view checkUser returns(uint){
        return _numX / _numY;
    }

    function modulo(uint _numX, uint _numY) public view checkUser returns(uint){
        return _numX % _numY;
    }
}