// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract StudentToken {

    string public name = "Student Token";
    string public symbol = "STU";

    uint256 public totalSupply;

    address public owner;

    mapping(address => uint256) public balanceOf;

    constructor(uint256 initialSupply) {

        owner = msg.sender;

        totalSupply = initialSupply;

        balanceOf[msg.sender] = initialSupply;
    }

    // AI-assisted: Transfer validation and balance update logic
    function transfer(
        address to,
        uint256 amount
    )
        external
        returns (bool)
    {
        require(
            balanceOf[msg.sender] >= amount,
            "Insufficient balance"
        );

        require(
            to != address(0),
            "Zero Address"
        );

        balanceOf[msg.sender] -= amount;

        balanceOf[to] += amount;

        return true;
    }

    // AI-assisted: Owner-only minting logic
    function mint(uint256 amount)
        external
    {
        require(
            msg.sender == owner,
            "Only owner can mint"
        );

        balanceOf[owner] += amount;

        totalSupply += amount;
    }

    // AI-assisted: Token burning logic
    function burn(uint256 amount)
        external
    {
        require(
            balanceOf[msg.sender] >= amount,
            "Insufficient balance"
        );

        balanceOf[msg.sender] -= amount;

        totalSupply -= amount;
    }
}