# Session 05 — ERC-20 Token

**Name:** Varshan R K
**Enrolment ID:** AU24UG040
**Submission Date:** 23/09/2026

## Project File

`StudentToken.sol`

## Overview

The purpose of this exercise is to create a basic ERC-20 token using the OpenZeppelin library. The contract creates a token named **Student Token** with the symbol **STK**.

When the contract is deployed, the account deploying it becomes the token creator and receives the initial token supply. The contract also provides a function to create additional tokens, but this function can only be used by the token creator.

## Contract Structure

The contract extends OpenZeppelin's `ERC20` contract:

```solidity
contract StudentToken is ERC20
```

This allows the contract to use the standard ERC-20 features provided by OpenZeppelin, such as balances, transfers, allowances, and total supply.

The address of the account that deploys the contract is stored in:

```solidity
address private tokenCreator;
```

During deployment, the initial supply is created and assigned to the token creator.

## Initial Token Supply

The constructor accepts the initial supply as an input:

```solidity
constructor(uint256 supply)
```

The supplied amount is passed to `_mint()`:

```solidity
_mint(tokenCreator, supply);
```

The value is represented in the token's smallest units. Since OpenZeppelin ERC-20 tokens use **18 decimals by default**, the value for one complete token is represented internally as:

`1 × 10^18`

For example, an initial supply of 1000 tokens would normally be entered as:

`1000 × 10^18`

## Minting Permission

Additional tokens can be created using:

```solidity
function createTokens(address receiver, uint256 amount)
```

Before minting, the contract checks whether the caller is the token creator:

```solidity
require(
    msg.sender == tokenCreator,
    "Caller is not the token creator"
);
```

If another account attempts to call this function, the transaction is rejected.

If the caller is authorized, the requested amount is minted to the selected receiver:

```solidity
_mint(receiver, amount);
```

## Testing the Contract

I tested the main ERC-20 functions after deployment:

1. Deploy the contract with an initial supply.
2. Check the token name using `name()`.
3. Check the token symbol using `symbol()`.
4. Verify the decimal value using `decimals()`.
5. Check the overall supply using `totalSupply()`.
6. Check the deployer's balance using `balanceOf()`.
7. Use `createTokens()` from the creator account to mint additional tokens.
8. Verify that the receiver's balance has increased.
9. Try calling `createTokens()` from another account and verify that the transaction is rejected.

## Deployment Details

**Network:** MetaMask

**Contract Address:** [Enter your deployed contract address]

## Learning Outcome

Through this exercise, I understood how an ERC-20 token can be created by extending an existing OpenZeppelin implementation instead of implementing the complete token standard manually.

I also learned how the constructor is used to create the starting supply, how the deployer's address can be stored for authorization, and how a `require` statement can restrict minting to a specific account.

Another important part was understanding ERC-20 decimals and the difference between the amount displayed to a user and the smaller unit stored by the contract.

## Resources and Assistance

I referred to OpenZeppelin documentation and AI-assisted explanations to understand the ERC-20 implementation, inheritance, minting, and decimal handling. I then used those concepts to write and test my contract.
