// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Vault is ReentrancyGuard {

    mapping(address => uint256) private userBalances;

    event Deposit(
        address user,
        uint256 amount,
        uint256 time
    );

    event Withdrawal(
        address user,
        uint256 amount,
        uint256 time
    );

    // Returns the total ETH stored in the contract
    function getVaultBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // Returns the ETH deposited by the caller
    function getMyBalance() external view returns (uint256) {
        return userBalances[msg.sender];
    }

    // Allows a user to deposit ETH into the vault
    function deposit() external payable {
        require(msg.value > 0, "Amount must be greater than zero");

        userBalances[msg.sender] += msg.value;

        emit Deposit(
            msg.sender,
            msg.value,
            block.timestamp
        );
    }

    // Allows the user to withdraw their deposited ETH
    function withdraw() external nonReentrant {
        address user = msg.sender;
        uint256 amount = userBalances[user];

        require(amount > 0, "No balance available");

        // Update balance before transferring ETH
        userBalances[user] = 0;

        (bool sent, ) = user.call{value: amount}("");

        require(sent, "ETH transfer failed");

        emit Withdrawal(
            user,
            amount,
            block.timestamp
        );
    }
}