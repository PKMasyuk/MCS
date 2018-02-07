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
