// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

interface ERC20interface{
function totalSupply() external view returns (uint256);
function balanceOf(address _owner) external view returns (uint256 balance);
function transfer(address _to, uint256 _value) external returns (bool success);
function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
function approve(address _spender, uint256 _value) external returns (bool success);
function allowance(address _owner, address _spender) external view returns (uint256 remaining);

event Transfer(address indexed _from, address indexed _to, uint256 _value);
event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

//implementing interface
contract Block is ERC20interface{
    string public name="Block"; //name of our token
    string public symbol="BLK"; //synbol for token like eth,btc

   string public decimal="0"; //tells upto how much places our token will be divisible
                            //for erc 20 it is 18 decimal place 
//     _setupDecimals(0);
    uint public override totalSupply;// will tell the total supply of erc token we have
    address public founder; //founder of this block token
    mapping(address=>uint) public balances; //this will keep track of the balances associated with a address
    mapping(address=>mapping(address=>uint)) allowed; //nexted mapping // for approval process
    constructor(){
        totalSupply=10000;
        founder=msg.sender;//who is deploying this contract
        balances[founder]=totalSupply;//initially all the supply will be with founder
        
    }
        function balanceOf(address _Owner) public view override returns(uint balance){
            return balances[_Owner]; // we are dterming the balance of a particular token owner
        }

        function transfer(address to,uint tokens) public override returns(bool success){
            require(balances[msg.sender]>=tokens);//check whether the msg.sender have enough tokens,if it is success 
            balances[to] +=tokens;
            balances[msg.sender] -=tokens;
         //emit event
            emit Transfer(msg.sender,to,tokens);
            return true;
        }
        
        function approve(address spender,uint tokens) public override returns(bool success){
 //spender is the one who we r approving to use our token  //eg:cheque
        require(balances[msg.sender]>=tokens);
        require(tokens>0);
        allowed[msg.sender][spender]=tokens;
         emit Approval(msg.sender,spender,tokens);
         return true;
    }

    //alllowance fuction ->returns the no of token the token owner ha actually approved the sender for
        function allowance(address tokenOwner,address spender) public view override returns(uint nooftokens){
              return allowed[tokenOwner][spender];
          }

        function transferFrom(address from,address to,uint tokens) public override returns(bool success){
         require(allowed[from][to]>=tokens);
         require(balances[from]>=tokens);
         balances[from] -=tokens;
         balances[to] +=tokens;
         return true;
         }
    
}
