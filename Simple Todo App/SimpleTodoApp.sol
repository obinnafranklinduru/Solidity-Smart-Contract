// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract SimpleTodoApp{
    address public user;

    event TodoCreated(string text);
    event TodoUpdated(uint index, string text);
    event TodoDeleted(uint index);
    event AllTodosDeleted();

    error InvalidUser();

    modifier validUser() {
        if(msg.sender != user)
            revert InvalidUser();
        _;
    }
    modifier OutOfBound(uint _index) {
        require(_index < todos.length, "Index out of bounds");
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
        emit TodoCreated(_text);
    }

    function updateText(uint _index, string calldata _text) 
    external 
    validUser 
    OutOfBound(_index)
    {
        todos[_index].text = _text;
        emit TodoUpdated(_index, _text);
    }

    function get(uint _index) 
    external 
    view
    OutOfBound(_index)
    returns(string memory, bool) 
    {
        Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }


    function toggleCompleted(uint _index) 
    external 
    validUser 
    OutOfBound(_index) 
    {
        todos[_index].completed = !todos[_index].completed;
    }

    function deleteTodo(uint _index) 
    external 
    validUser 
    OutOfBound(_index) 
    {
        todos[_index] = todos[todos.length - 1];
        todos.pop();
        emit TodoDeleted(_index);
    }

    function deleteAllTodos() external validUser {
        delete todos;
        emit AllTodosDeleted();
    }

    function lengthOfTodo() external view returns(uint){
        return todos.length;
    }
}