// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

contract SimpleTodoApp{
    address public user;

    error InvalidUser();

    modifier validUser() {
        if(msg.sender != user)
            revert InvalidUser();
        _;
    }

    constructor() {
        user = msg.sender;
    }

    struct Todo{
        string text;
        bool completed;
    }

    Todo[] todos;

    function create(string calldata _text) external validUser {
        todos.push(Todo({text: _text, completed: false}));
    }

    function updateText(uint _index, string calldata _text) external validUser {
        todos[_index].text = _text;
    }

    function get(uint _index) external view returns(string memory, bool) {
        Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function toggleCompleted(uint _index) external validUser {
        todos[_index].completed = !todos[_index].completed;
    }

    function deleteTodo(uint _index) external validUser {
        todos[_index] = todos[todos.length - 1];
        todos.pop();
    }

    function deleteAllTodos() external validUser {
        delete todos;
    }

    function lengthOfTodo() external view returns(uint){
        return todos.length;
    }
}