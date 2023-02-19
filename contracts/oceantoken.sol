//contracts/oceantoken.sol
//SPDX-License-Identifier:MIT


pragma solidity ^0.8.17;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.8.1/contracts/token/ERC20/ERC20.sol";
contract oceantoken is ERC20{ 
        //we are inheriting from erc20 zeppelin
        constructor(uint256 initialsupply) ERC20("OceanToken","OCT"){
            _mint(msg.sender,initialsupply);
        }



}