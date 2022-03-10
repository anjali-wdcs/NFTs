// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint amount) external returns(bool);
    function balanceOf(uint amount) external view returns(uint);
    function allowance(address owner, address spender) external view returns(uint);
}

interface IERC721 {
    function safeTransferFrom(address from, address to, uint tokenId) external;
}

interface IERC1155 {
    function safeTransferFrom(address from, address to, uint amount, bytes calldata data) external;
}


contract airdrop {
    
    function airdropERC20(IERC20 _token, address[] calldata _to, uint[] calldata _amount) public {
        require(_to.length == _amount.length, "Receivers and amounts are of different length");
        
        for(uint i=0; i<_to.length; i++) {
            require(_token.transferFrom(msg.sender, _to[i], _amount[i]));
        }
    } 

    function airdropERC721(IERC721 _token, address[] calldata _to, uint[] calldata _id) public {
        require(_to.length == _id.length, "Receivers and ids are of different length");

        for(uint i=0; i<_to.length; i++) {
            _token.safeTransferFrom(msg.sender, _to[i], _id[i]);
        }
    }

    function airdropERC1155(IERC1155 _token, address[] calldata _to, uint[] calldata _id, uint[] calldata _amount) public {
        require(_to.length == _id.length, "Receivers and ids are of different length");

        for(uint i=0; i<_to.length; i++) {
            _token.safeTransferFrom(msg.sender, _to[i], _id[i], _amount[i]);
        }
    }

}
