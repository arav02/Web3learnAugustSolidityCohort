// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract vote{
    string public winner="NOT yet Declared";
    address payable public  candidate1 = payable(0x617F2E2fD72FD9D5503197092aC168c91465E7f2);
    address payable public  candidate2 = payable(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);
    mapping(address=>uint) user;
    mapping(address=>bool) chek;
    uint votingtimeperiod; // store the time at which contract was deployed
    address payable public owner;
    constructor(){
        owner = payable(msg.sender);
        votingtimeperiod = block.timestamp + 15 minutes;
    }

    modifier onlyowner(){
        require(msg.sender == owner,"You are not allowed to declare the result");
        _;
    }
   
    function candidate1_vote()  public  payable{
       
        require(block.timestamp < votingtimeperiod,"Voting Closed");
        require(msg.sender !=candidate1,"You cannot vote to yourself");
        require(chek[msg.sender]!=true,"You have already voted");
        //check whether exaclty 1 ether is being sent
        require(msg.value == 1 ether,"send exactly 1 ether to approve your vote");
        user[candidate1]++;
        chek[msg.sender] = true;
    }
        function candidate2_vote()  public payable {
        require(block.timestamp < votingtimeperiod,"Voting closed");
        require(msg.sender !=candidate2,"You cannot vote to yourself");
        require(chek[msg.sender]!=true,"You have already voted");
        require(msg.value == 1 ether,"send exactly 1 ether to approve your vote");
        user[candidate2]+=1;
        chek[msg.sender] = true;
    }

    function Candidate1_VOTES() view public  returns(uint){
        return user[candidate1];

    }

    function Candidate2_VOTES() view public  returns(uint){
        return user[candidate2];

    }

    function declare_winner()  public onlyowner {
        if(user[candidate1]>user[candidate2]){
            winner = "Candidate 1 is winner";
            
        }
        else if(user[candidate1]==user[candidate2]){
            winner = "Draw";
            

        }
        else{
            winner = "Candidate 2 is winner";   
        }
        
 // transfer collected amount to owner account;
         owner.transfer(address(this).balance);
    }

    function viewContractBalance() public view onlyowner returns(uint){
        return address(this).balance;
    }

}
