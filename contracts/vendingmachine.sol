//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract vendingmachine{

    address public owner; //this address holds 20bytes of data which is the size of an ethereum address 
    mapping(address=>uint) public donutbalances; //mapping of ethereum addresses to number of donuts that each address owns
    
    constructor(){
        owner=msg.sender;  //setting the owner by using msg.sender global variable. So sender is the ethereum address of the originator call or the transaction 
        //so when the smart contract will get deployed it will call the constructor and hence it will define who the owner of the smart contract is.

        //next thing we have to do is to set the inital value of the donut balance for the vending machine of 100

        
        donutbalances[address(this)]=100;   //address(this) is the way to give the address of the current contract and also this is not going to only handle the balance of the vending machine but also the anybody who interact with the vending machine or purchase a donut from this vending machine 


    }

    function getvendingmachinebalance() public view returns(uint){
        return donutbalances[address(this)];

    }

    //now restock function will allow the owner of the vending machine to add more donuts to the machine 

    function restock(uint amount )public {
        require(msg.sender==owner,"only owner can restock this machine");
        donutbalances[address(this)]+=amount;

    }

    //purchase function will take one argument that amount of donuts one wishes to purchase from the vending machine and it will recieve ether so we have to use payable in the function otherwise the transaction will be reverted 

    function purchase(uint amount) public payable{
        require(msg.value>=amount*2 ether,"you must pay atleast 2 ether per donuts");
        require(donutbalances[address(this)]>=amount,"Not enough donuts in the vending machine ");
        donutbalances[address(this)]-=amount;
        donutbalances[msg.sender]+=amount;
    }






}