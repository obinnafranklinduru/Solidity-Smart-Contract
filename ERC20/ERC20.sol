// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    uint256 public totalSupply;
    uint256 public decimals = 18;
    string public name;
    string public symbol;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function transfer(address _to, uint256 _value) external returns (bool success){
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success){
        allowance[_from][msg.sender] -= _value;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    function approve(address _spender, uint256 _value) external returns (bool success){
        allowance[msg.sender][_spender] += _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    function mint(uint256 _value) external {
        balanceOf[msg.sender] += _value;
        totalSupply += _value;
        emit Transfer(address(0), msg.sender, _value);
    }
    function burn(uint256 _value) external {
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        emit Transfer(msg.sender, address(0), _value);
    }
}