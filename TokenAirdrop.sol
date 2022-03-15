// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "Token.sol";

contract airdrop is Ownable {
    using SafeMath for uint;

    address public tokenAdr;

    event EtherTransfer(address to, uint amount);

    constructor(address _tokenAdr) {
        tokenAdr =_tokenAdr;
    }

   
   function dropTokens(address[] memory _recipients, uint[] memory _amount) public onlyOwner returns(bool) {

        for(uint i=0; i < _recipients.length; i++) {
            require(_recipients[i]!= address(0));
            require(MyToken(tokenAdr).transfer(_recipients[i], _amount[i]));
        }

        return true;
    }

   
   function dropEther(address[] memory _recipients, uint[] memory _amount) public payable onlyOwner returns(bool) {
        uint total = 0;

        for(uint j=0; j < _amount.length; j++) {
            total = total.add(_amount[j]);
        }

        require(total <= msg.value);
        require(_recipients.length == _amount.length);

        for(uint i=0; i < _recipients.length; i++) {
            require(_recipients[i] != address(0));

            payable(_recipients[i]).transfer(_amount[i]);

            emit EtherTransfer(_recipients[i], _amount[i]);
        }

        return true;
    }
    
    
    function updateTokenAdr(address newTokenAdr) public onlyOwner {
        tokenAdr = newTokenAdr;
    }

    
    function withdrawTokens(address receiver) public onlyOwner {
        require(MyToken(tokenAdr).transfer(receiver, MyToken(tokenAdr).balanceOf(address(this))));
    }

    
    function withdrawEther(address payable receiver) public onlyOwner {
        receiver.transfer(address(this).balance);
    }
}
