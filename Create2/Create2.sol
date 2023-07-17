// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DeployWithCreate2{
    address public owner;

    constructor(address _owner){
        owner = _owner;
    }
}

contract Create2Factory{
    address public addr;

    function deploy(uint _salt) public {
        // This is the normal way of creating an instance of a contract.
        // DeployWithCreate2 _contract = new DeployWithCreate2(msg.sender);

        // Salt can be a random 32bytes.
        // Salt is introduced in create2 to provide a way of deterministically generating an address 
        // for a contract before it is deployed. In other words, using create2 and a salt value, 
        // it is possible to know the address that 
        // a contract will have before it is actually deployed to the Ethereum network.
        DeployWithCreate2 _contract = 
        new DeployWithCreate2{salt: bytes32(_salt)}(msg.sender);

        // We enclose it in address var because _contract cannot be directly converted to address.
        addr = address(_contract);
    }

    // How to know the address of the contract to deploy before deploying it
    function getAddress(bytes memory _bytecode, uint _salt) public view returns(address) {
        // The bytes1(0xff) is used as a prefix in the keccak256 hash function 
        // to specify the type of deployment being performed.
        // The address of a create2 contract is determined by the combination of the contract deployer, 
        // a 32-byte salt value, and the Keccak-256 hash of the contract's bytecode.
        bytes32 hash = keccak256(abi.encodePacked(
            bytes1(0xff), address(this), _salt, keccak256(_bytecode)
        ));

        // bytes32 => uint256: The hash value is first converted to a uint256
        // uint256 => uint160: The uint value is then converted to a uint160 
        // because Ethereum addresses are 160-bit values.
        // uint160 => address: The uint160 value is converted to an Ethereum address type.
        return address(uint160(uint(hash)));
    }

    // To get the bytecode of the contract to be deployed
    function getByteCode(address _owner) public pure returns(bytes memory) {
        // type keyword is used to access the type information of a contract
        // creationCode property returns the bytecode 
        // that is required to deploy a new instance of the contract.
        // type(<contractName>).creationCode can get the bytecode of any contract
        bytes memory bytecode = type(DeployWithCreate2).creationCode;

        // This combined bytecode and encoded owner address will be used to deploy 
        // a new instance of the DeployWithCreate2 contract with the desired owner.
        return abi.encodePacked(bytecode, abi.encode(_owner));
    }
}