// SPDX-License-Identifier: MIT  

pragma solidity ^0.8.7;
import "@openzeppelin/contracts/access/Ownable.sol";
contract mutlipleRoles{
address owner; 
//nested mapping
mapping (bytes32 =>mapping (address =>bytes32)) public xyz;
bytes32 public Addition=keccak256((abi.encode("Addition")));
bytes32 public Subtraction=keccak256((abi.encode("Subtraction")));

constructor(){
    owner=msg.sender;
}

function SetRole(address _addr, bytes32 _roles) public {
    require(owner ==msg.sender,"not accessible");
    xyz[_roles][_addr]=_roles;
}

}
