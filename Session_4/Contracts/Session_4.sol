// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract Vault {

    mapping(address => uint256) balances;

    event Deposited(
        address userAddress,
        uint256 amount,
        uint256 depositedAt
    );

    event Withdrawn(
        address userAddress,
        uint256 amount,
        uint256 withdrawnAt
    );

    function getContractBalance()
        external
        view
        returns (uint256)
    {
        return address(this).balance;
    }

    function getBalance()
        public
        view
        returns (uint256)
    {
        return balances[msg.sender];
    }

    // AI-assisted: Deposit validation, balance update and event logic
    function deposit()
        external
        payable
    {
        require(msg.value > 0, "Zero Amount");

        balances[msg.sender] += msg.value;

        emit Deposited(
            msg.sender,
            msg.value,
            block.timestamp
        );
    }

    // AI-assisted: Withdrawal logic using Checks-Effects-Interactions
    function withdraw()
        external
    {
        address recepient = msg.sender;

        uint256 amount = balances[recepient];

        // CHECK
        require(
            amount > 0,
            "Nothing to Withdraw"
        );

        // EFFECT
        balances[recepient] = 0;

        // INTERACTION
        (bool success, ) = msg.sender.call{value: amount}("");

        require(
            success,
            "Transfer failed"
        );

        emit Withdrawn(
            recepient,
            amount,
            block.timestamp
        );
    }
}