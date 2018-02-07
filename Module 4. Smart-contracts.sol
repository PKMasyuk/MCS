//TASK # 1

pragma solidity ^0.4.11;        //Solidity version for compilation

contract First                  //Declare a smart-contract
{
    uint public integer;        //Declare a "uint"-type variable for everyone

    function showInt(uint _integer) public //Function to show a value of variable
    {
        integer = _integer;     //Our public variable is assigned a value
    }
}

//TASK # 2

pragma solidity ^0.4.11;            //Solidity version for compilation

contract Second                     //Declare a smart-contract
{
    uint public value;            //Declare a variable with "uint"-type for everyone
    uint public Price = 6 finney;   //Declare a public variable with price of message

    function showInt(uint _value) public payable//Function to show a value of variable
    {                                             //...opened for payments from anyone
        require(msg.value > Price);   //Checking for sufficiency of incoming sum
        value = _value;             //Our public variable is assigned a value
    }
}


//TASK # 3

pragma solidity ^0.4.11;            //Solidity version for compilation

contract Third                      //Declare a smart-contract
{
    address public recipient;       //Address of contract's owner
    string public message;          //Published massage
    uint public messagePrice = 10 finney;

    function Third() public         //Modify function for owner address is payable for everyone
    {
        recipient = msg.sender;
    }

    function putMes(string _message) public payable
    {
        require(msg.value >= messagePrice); //Checking function sufficiency of incoming sum
        message = _message;                 //Published massage
        recipient.transfer(msg.value);       //Transfer the sum to the owner's address
    }
}


//Task № 4

pragma solidity ^0.4.11;            //Solidity version for compilation

contract Fourth                     //Declare a smart-contract
{
    address public recipient;       //Address of contract's owner
    string public message;          //Published massage
    uint public messagePrice = 10 finney;
    uint public TimeMessage;        //Time of the last message
    uint public TimeOut = 10 seconds; //Waiting time for a new message

    function Fourth() public
    {
        recipient = msg.sender;
    }

    function putMes(string _message) public payable
    {
        require(msg.value >= messagePrice);     //Is the sum from user enought for contract
        require(TimeMessage + TimeOut < now);   //Can the message be Published
        message = _message;                     //Published message
        recipient.transfer(msg.value);          //Transfer the sum to the owner's address
        TimeMessage = now;                      //Updating a variable of time of publishing
    }
}
