# Will Statement
The Will Statement smart contract is a simple contract that allows the owner to specify how their assets should be distributed upon their death.

### Features
- The owner can specify an inheritance amount for each beneficiary using the setInheritance function.
- The owner can mark their assets as decreased using the isDecreased function.
- When the assets are marked as decreased, the contract will distribute the specified inheritance amounts to the beneficiaries.

### Modifiers
The contract has two modifiers: onlyOwner and mustBeDecreased.
- The onlyOwner modifier allows only the owner to call a function.
- The mustBeDecreased modifier allows a function to be called only when the assets have been marked as decreased.

### Events
The contract does not have any events.

### Security considerations
- The contract has a very simple security design and does not have any protection against malicious actors.
- The owner should be careful when setting the inheritance amounts and distributing the assets, as there is no way to reverse the process once it has been completed.
- The contract is also not designed to handle situations where the owner becomes incapacitated or is unable to mark their assets as decreased. It is recommended to use a more robust contract or legal agreement for these situations.