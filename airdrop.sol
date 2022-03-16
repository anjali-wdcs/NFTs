// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract Token {
    function transfer(address to, uint amount) public virtual returns(bool);
    event Transferred(address indexed from, address indexed to, uint indexed amount);
}

contract airdropCreation is Ownable {
    Token public tokInstance;
    
    constructor(address _tokAdr) {
        tokInstance = Token(_tokAdr);
    }
    
   
   function airdropTokens(address[] memory recipients, uint[] memory amount) public onlyOwner {
        for(uint i=0; i < recipients.length; i++) {
            require(recipients[i] != address(0));
            tokInstance.transfer(recipients[i], amount[i]);
        }
    }    
    
    function sendBatch(address[] memory recievers, uint[] memory amount) public onlyOwner returns(bool) {
        require(recievers.length == amount.length);
        for(uint i=0; i < amount.length; i++){
            tokInstance.transfer(recievers[i], amount[i]);
        }
        
        return true;
    }
}

