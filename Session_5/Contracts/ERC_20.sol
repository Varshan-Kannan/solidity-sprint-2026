 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StudentToken is ERC20 {

    address private tokenCreator;

    constructor(uint256 supply) ERC20("Student Token", "STK") {
        tokenCreator = msg.sender;
        _mint(tokenCreator, supply);
    }

    function createTokens(address receiver, uint256 amount) public {
        require(
            msg.sender == tokenCreator,
            "Caller is not the token creator"
        );

        _mint(receiver, amount);
    }
}