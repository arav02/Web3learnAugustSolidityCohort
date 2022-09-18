// SPDX-License-Identifier: MIT  

pragma solidity ^0.8.7;
contract ABC{

    address owner;
    mapping(address=>bytes32) public xyz;
    bytes32 public addition=keccak256(abi.encodePacked("Addition"));
    bytes32 public subtraction=keccak256(abi.encodePacked("Subtraction"));
    constructor(){
        owner=msg.sender;
    }

    function setRoles(address _addr,bytes32 _roles) public{
        require(owner==msg.sender,"Not accessible");
        xyz[_addr]=_roles;
        xyz[owner]=_roles;
    }
    function addTwoNumbers(uint _a,uint _b) public view returns(uint){
        require(xyz[msg.sender]==addition);
                return _a+_b;
    }
    function SubTwoNumbers(uint _a,uint _b) public view returns(uint){
        require(owner == msg.sender,"not accessible");
        return _a+_b;
    }

}
