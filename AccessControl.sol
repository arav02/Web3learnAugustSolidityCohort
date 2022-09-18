// SPDX-License-Identifier: MIT  

pragma solidity ^0.8.7;
import "@openzeppelin/contracts/access/Ownable.sol";
contract mutlipleRoles{
address owner; 
//nested mapping
mapping (bytes32 =>mapping (address =>bytes32)) public xyz;
//[Addition][msg.sender]=>bytes32
bytes32 public Addition=keccak256((abi.encode("Addition")));
bytes32 public Subtraction=keccak256((abi.encode("Subtraction")));

constructor(){
    owner=msg.sender;
}

function SetRole(address _addr, bytes32 _roles) public {
    require(owner ==msg.sender,"not accessible");
    xyz[_roles][_addr]=_roles;
}

function addTwoNumbers(uint _a,uint _b,bytes32 _roles) public view returns(uint){
        require(xyz[_roles][msg.sender]==Addition,"not accessible");
        return _a + _b;
    }
function SubTwoNumbers(uint _a,uint _b,bytes32 _roles) public view returns(uint){
        require(xyz[_roles][msg.sender]==Subtraction,"not accessible");
        require(_a >= _b,"result is negative");
        return _a - _b;
    }

}
