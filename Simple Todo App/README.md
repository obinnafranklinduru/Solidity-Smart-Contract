# SimpleTodoApp Contract

## Description

The `SimpleTodoApp` contract allows a single user to create, update, and delete to-do items. Each to-do item consists of a text description and a completion status.

### Events

- `TodoCreated(string text)`: Triggered when a new to-do item is created.
- `TodoUpdated(uint index, string text)`: Triggered when an existing to-do item is updated.
- `TodoDeleted(uint index)`: Triggered when a to-do item is deleted.
- `AllTodosDeleted()`: Triggered when all to-do items are deleted.

### Variables

- `user` (address): The address of the user who owns the to-do list.

### Modifiers

- `validUser()`: Ensures that the caller is the user who owns the to-do list.
- `OutOfBound(uint _index)`: Ensures that the provided index is within the range of the existing to-do items.

### Struct

- `Todo`: Represents a to-do item with a text description and completion status.

### Functions

The `SimpleTodoApp` contract provides the following functions:

#### `constructor()`

Initializes the contract by setting the deployer's address as the user.

#### `create(string calldata _text) external validUser`

Creates a new to-do item with the given text.

#### `updateText(uint _index, string calldata _text) external validUser OutOfBound(_index)`

Updates the text of an existing to-do item at the specified index.

#### `get(uint _index) external view OutOfBound(_index) returns(string memory, bool)`

Retrieves the text and completion status of a to-do item at the specified index.

#### `toggleCompleted(uint _index) external validUser OutOfBound(_index)`

Toggles the completion status of a to-do item at the specified index.

#### `deleteTodo(uint _index) external validUser OutOfBound(_index)`

Deletes a to-do item at the specified index.

#### `deleteAllTodos() external validUser`

Deletes all to-do items.

#### `lengthOfTodo() external view returns(uint)`

Returns the number of to-do items in the list.

## License

This code is licensed under the GPL-3.0 License.
