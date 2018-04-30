pragma solidity ^0.4.11;

//Ownable contract
contract Ownable
{
    address public owner;

    function Ownable()
    {
        owner = msg.sender;
    }

    modifier onlyOwner()
    {
        require(msg.sender == owner);
        _;
    }
}


//Initialize a contract
contract Pakom
{
    //Constant variables
    string public version = "a1.0";
    string public constant name = "Pakom";              //Name of token
    string public constant symbol = "PKM";              //Symbol of token
    uint8 public constant decimals = 18;                //Decimals in token
    uint256 public totalSupply = 1000000;               //Amount of tokens

    //Mappings
    mapping (address => uint256) public balanceOf;                      //...for user's balances & "transfer"-functions
    mapping (address => mapping (address => uint256)) public allowance; //...for "approve"-function

    //Events
    event Transfer(address from, address to, uint256 value);
    event Approval(address owner, address spender, uint256 value);

    function Pakom(uint256) public
    {
        balanceOf[msg.sender] = totalSupply;     //Creating tokens for owner
    }

    //Function of sending tokens
    function trasfer(address _to, uint256 _value) public returns (bool)
    {
        //Checking for...
        require(_to !=address(0));                              //...address existing
        require(_value <= balanceOf[msg.sender]);               //...sender's balances
        require(balanceOf[_to] + _value >= balanceOf[_to]);     //...overflow
        require(_value > 0);                                    // Sum of the trasaction should be greater than 0

        balanceOf[msg.sender] -= _value;                        //Take tokens from sender

        balanceOf[_to] += _value;                               //Give tokens to recipient
        Transfer(msg.sender, _to, _value);
        return true;
    }

    //Function for transfering tokens from address to address
    function approve(address _spender, uint256 _value) public returns (bool)
    {
        allowance[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    //Function for transfering tokens by anybody
    function trasferFrom(address _from, address _to, uint256 _value) public returns (bool)
    {
        //Checking for...
        require(_to != address(0));                             //...address existing
        require(_value <= balanceOf[_from]);                    //...sender's balances
        require(_value <= allowance[_from][msg.sender]);        //...is the transaction allowed for sender
        require(balanceOf[_to] + _value >= balanceOf[_to]);     //...overflow
        require(_value > 0);                                    //Sum of the trasaction should be greater than 0

        balanceOf[_from] -= _value;                             //Take tokens from sender
        balanceOf[_to] += _value;                               //Add tokens to recipient
        allowance[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }
}

contract Mintable is Pakom
{
    event Mint(address indexed to, uint256 amount);
    event MintFinished();
    bool public mintingFinished = false;
    modifier canMint()
    {
        require(!mintingFinished);
        _;
    }

    function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool)
    {
        totalSupply = totalSupply + _amount;
        balanceOf[_to] = balanceOf[_to] + _amount;
        Mint(_to, _amount);
        Transfer(address(0), _to, _amount);
        return true;
    }

    function finishMinting() onlyOwner public returns (bool)
    {
        mintingFinished = true;
        MintFinished();
        return true;
    }
}
