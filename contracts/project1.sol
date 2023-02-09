//SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.5.0;

contract lottery{
    address public manager;    //we will store the address of the manager since manager is contesting a lottery
    address payable[] public participants; //payable is if we have to send anyone some ether we can use variable as payable.
    //since here we have to pay ether to winner of this lottery so we will make participant as payable.


    constructor(){
        manager=msg.sender;  //particular account address will be automatically transferred to the managers account and eventually manager will be the one controlling whole lottery event

    }
    receive() external payable{   
           //receive function can be used only once in contract and this can be used by using external after receive and it will 
           require(msg.value==0.0001 ether);//require is the if and else statement in solidity 
           participants.push(payable(msg.sender));//here we are pushing the participants address for the transaction to be pushed


    }
    function getbalance() public view returns(uint){
        require(msg.sender==manager); //if the address is of the manager then only return the balance to this address
        return address(this).balance;  //this function returns the address of the participants from whom transacted some of the ethers 
    }
    function  random() public view returns(uint){   //here we will generate a random 256 sha units of numbers like random numbers 
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }
    function selectwinner() public {  //here in this function we will select the winner of the lottery 
        require(msg.sender==manager);  //using if else (require statement) msg.sender will be the manager 
        require(participants.length>=3); //and the participants should be greater or equal to the 3 for the lottery to be happened
        uint r=random();  //we will store the random numbers of 256 length in r variable
        address payable winner; //now we will choose the winner as payable so we should pay him after the contest on this address
        uint index=r%participants.length; //since 256 unit number if it is divided by the no of participants the remainder will be less than that of the no of participants so it will give some random number in between 1 to 3 so we can select the winner of the lottery this way randomly
        winner=participants[index]; //now we will keep the winner in the winner address
        winner.transfer(getbalance()); //now we will transfer the ether amount to the winner 
        participants=new  address payable[](0); //this will empty the dynamic array of the participants meaning the closing of the lottery contest

    }

}