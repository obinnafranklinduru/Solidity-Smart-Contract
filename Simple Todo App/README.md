# Overview
The SimpleTodoApp contract is a simple todo list application that allows a user to create, update, and delete todos. The user can also toggle the completion status of a todo, and delete all todos in the list.

## The contract includes the following functions:

### create(string calldata _text)
This function allows the user to create a new todo with the specified _text. The todo will be added to the end of the list and will have a completion status of false.

### updateText(uint _index, string calldata _text)
This function allows the user to update the text of a todo at the specified _index with the new _text.

### get(uint _index)
This function returns the text and completion status of the todo at the specified _index.

### toggleCompleted(uint _index)
This function toggles the completion status of the todo at the specified _index. If the todo is completed, it will be set to incomplete. If the todo is incomplete, it will be set to complete.

### deleteTodo(uint _index)
This function deletes the todo at the specified _index.

### deleteAllTodos()
This function deletes all todos in the list.

### lengthOfTodo()
This function returns the number of todos in the list.

## Events
The SimpleTodoApp contract includes the following events:

### TodoCreated(string text)
This event is emitted when a todo is created with the specified text.

### TodoUpdated(uint index, string text)
This event is emitted when the text of a todo at the specified index is updated with the new text.

### TodoDeleted(uint index)
This event is emitted when a todo at the specified index is deleted.

### AllTodosDeleted()
This event is emitted when all todos in the list are deleted.

### Restrictions
Only the user who deployed the contract can access its functions. Any other address that tries to call a function will receive an error.