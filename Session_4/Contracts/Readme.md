# Session 04

**Name:** Varshan R K
**Enrolment ID:** Au24UG040
**Date submitted:** 22/09/2026

## Contract

* `Vault.sol`

## 1. Purpose of the contract

The `Vault` contract allows users to deposit Ether into the contract and later withdraw the amount associated with their own address.

Each user's deposited amount is stored separately using a mapping. The contract also provides a function to check the total Ether currently held by the vault.

Deposits and withdrawals generate events containing the user's address, the amount involved, and the block timestamp.

## 2. Contract implementation

The contract uses:

```solidity
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
```

and inherits from `ReentrancyGuard`:

```solidity
contract Vault is ReentrancyGuard
```

This provides protection against reentrancy attacks for the withdrawal function.

Individual balances are maintained using:

```solidity
mapping(address => uint256) private userBalances;
```

The mapping connects each user's wallet address with the amount of Ether they have deposited.

## 3. Depositing Ether

The `deposit()` function is marked as `payable`, allowing Ether to be sent along with the function call.

The contract first checks that the amount sent is greater than zero:

```solidity
require(msg.value > 0, "Amount must be greater than zero");
```

The deposited amount is then added to the caller's existing balance:

```solidity
userBalances[msg.sender] += msg.value;
```

After the deposit, a `Deposit` event is emitted with the sender's address, deposited amount, and timestamp.

## 4. Checking balances

There are two different balance functions in the contract.

`getVaultBalance()` returns the total Ether currently held by the contract:

```solidity
return address(this).balance;
```

`getMyBalance()` returns the balance recorded for the account calling the function:

```solidity
return userBalances[msg.sender];
```

The first represents the vault's overall Ether balance, while the second represents an individual user's recorded deposit.

## 5. Withdrawal process

The `withdraw()` function allows a user to withdraw their recorded balance.

It uses:

```solidity
nonReentrant
```

to protect the function against reentrancy attacks.

The user's stored balance is first retrieved and checked:

```solidity
require(amount > 0, "No balance available");
```

Before sending Ether externally, the user's stored balance is set to zero:

```solidity
userBalances[user] = 0;
```

The Ether is then transferred using the low-level `call` method:

```solidity
(bool sent, ) = user.call{value: amount}("");
```

The return value is checked to make sure the transfer was successful.

## 6. Reentrancy protection

The main security feature in this contract is the `ReentrancyGuard` provided by OpenZeppelin.

The following modifier is applied to the withdrawal function:

```solidity
function withdraw() external nonReentrant
```

This prevents the same function from being entered again while the original withdrawal is still executing.

The balance is also cleared before the Ether transfer:

```solidity
userBalances[user] = 0;
```

This provides an additional protection by ensuring that the user's balance is no longer available for another withdrawal during the transfer process.

## 7. Events

The contract defines two events:

```solidity
event Deposit(
    address user,
    uint256 amount,
    uint256 time
);
```

and:

```solidity
event Withdrawal(
    address user,
    uint256 amount,
    uint256 time
);
```

These events record important deposit and withdrawal activity. The timestamp is taken from `block.timestamp`.

## 8. Deployment

* **Network:** Remix VM
* **Contract:** `Vault`
* **Contract address:** [Enter your deployed contract address]
* **Transaction hash:** [Enter transaction hash if required]
* **Block explorer:** N/A for Remix VM unless using a public network

## 9. Testing

I tested the vault using different accounts and Ether amounts.

1. Call `deposit()` with zero Ether → transaction should revert with `"Amount must be greater than zero"`.
2. Deposit Ether from Account A → the transaction succeeds and a `Deposit` event is generated.
3. Call `getMyBalance()` from Account A → confirms the deposited amount.
4. Deposit another amount from Account B → confirms that balances are maintained separately.
5. Call `getVaultBalance()` → shows the combined Ether held by the contract.
6. Call `withdraw()` from Account A → the stored balance is transferred to Account A.
7. Call `getMyBalance()` again from Account A → returns `0`.
8. Try withdrawing again from Account A → transaction reverts with `"No balance available"`.
9. Withdraw the balance from Account B → confirms that Account B can withdraw its own deposited amount.
10. Check `getVaultBalance()` after all withdrawals → confirms that the vault balance has decreased accordingly.

## 10. Key learning

This exercise helped me understand how payable functions work in Solidity and how `msg.value` represents the Ether sent with a transaction.

I also learned the difference between the contract's total Ether balance and the individual balances stored in a mapping.

The security aspect was another important part of the exercise. I learned about reentrancy attacks and how OpenZeppelin's `ReentrancyGuard` can be used to protect a function that sends Ether to an external address.

I also understood why the user's balance should be updated before making the external Ether transfer.

## 11. Acknowledgements

I used AI assistance to understand payable functions, `msg.value`, Ether transfers using `call`, mappings for user balances, and reentrancy protection using OpenZeppelin's `ReentrancyGuard`. I also referred to OpenZeppelin documentation while understanding the security implementation. The final contract was implemented and tested by me in Remix.
