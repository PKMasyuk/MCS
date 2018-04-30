pragma solidity ^0.4.11;

//Declare an interface
interface Pakom
{
    function trasfer(address _receiver, uint256 _value);
}

//Declare a contract
contract FirstICO
{
    uint256 public Price;       //Variable for token's Price
    Pakom public token;         //Variable for keepeing a token

    //Initialize token
    function FirstICO(Pakom _token) public
    {
        token = _token;
        Price = 10000;
    }

    //Internal function for direct transfer of tokens
    function () public payable
    {
        _buy(msg.sender, msg.value);
    }

    //Calling the internal function for buying tokens
    function buy() public payable returns (uint256)
    {
        uint256 tokens = _buy(msg.sender, msg.value);
        return tokens;
    }

    //Internal function for buying tokens
    function _buy(address _sender, uint256 _amount) internal returns (uint256)
    {
        uint256 tokens = _amount/Price;     //Calculate the cost
        token.transfer(_sender, tokens);    //Sent tokens
        return tokens;
    }
}



