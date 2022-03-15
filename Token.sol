// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint supply) ERC20("Gconomy", "GCO") {
        _mint(msg.sender, supply);
    }

}
