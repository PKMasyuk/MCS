pragma solidity ^0.4.11;

//Initialize a contract
contract Pakom
{
    //Constant variables
    string public version = "a1.0";
    string public constant name = "Pakom";              //Name of token
    string public constant symbol = "PKM";              //Symbol of token
    uint8 public constant decimals = 18;                //Decimals in token
    uint256 public constant _supply = 1000000;      //Amount of tokens

    //Mappings
    mapping (address => uint256) public balanceOf;               //...for user's balances & "transfer"-functions
    mapping (address => mapping (address => uint256)) public allowed; //...for "approve"-function

    //Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);


    function Pakom(uint256) public
    {
        balanceOf[msg.sender] = _supply;     //Creating tokens for owner
    }

    //Total amount of tokens                                ///Так и не вышло реализовать эту функцию
    // function totalSupply () public view returns (uint256) ///компиляция удалась только через строку 11
    // {                                                     ///и мне так и не удалось понять: почему.
    //     return _supply;
    //}

    //Function to get amount of token at the address
    function balanceOf(address _owner) public constant returns (uint256)
    {
        return balanceOf[_owner];
    }

    //Function of sending tokens
    function trasfer(address _to, uint256 _value) public returns (bool)
    {
        //Checking for...
        require(_to !=address(0));                          //...address existing
        require(_value <= balanceOf[msg.sender]);            //...sender's balances
        require(balanceOf[_to] + _value >= balanceOf[_to]); //...overflow
        require(_value > 0);                                // Sum of the trasaction should be greater than 0

        balanceOf[msg.sender] -= _value;         //Take tokens from sender

        balanceOf[_to] += _value;                //Give tokens to recipient
        Transfer(msg.sender, _to, _value);
        return true;
    }

    //Function for transfering tokens from address to address
    function approve(address _spender, uint256 _value) public returns (bool)
    {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    //Function for transfering tokens by anybody
    function trasferFrom(address _from, address _to, uint256 _value) public returns (bool)
    {
        //Checking for...
        require(_to != address(0));                         //...address existing
        require(_value <= balanceOf[_from]);                 //...sender's balances
        require(_value <= allowed[_from][msg.sender]);      //...is the transaction allowed for sender
        require(balanceOf[_to] + _value >= balanceOf[_to]); //...overflow
        require(_value > 0);                                //Sum of the trasaction should be greater than 0

        balanceOf[_from] -= _value;                          //Take tokens from sender
        balanceOf[_to] += _value;                            //Add tokens to recipient
        allowed[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }

    //Function returns the allowed amount of tokens for some users
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }
}