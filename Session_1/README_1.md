# Session 01

Create a Solidity contract that stores a message and records the address that most recently updated it.

**Name:** Varshan R K
**Enrolment ID:** AU24UG040
**Date submitted:** 16/09/2026

## Contract

* `Storage.sol`

## 1. Purpose of the contract

The `Storage` contract is used to save a text message on the blockchain. It also stores the address of the account that performed the latest update.

The contract provides one function for changing the stored message and two functions for retrieving the saved message and the address of the last editor.

## 2. Implementation approach

I used two state variables in the contract:

```solidity
string message;
address lastEditor;
```

The `message` variable holds the current text, while `lastEditor` keeps the address of the account that most recently modified it.

The `updateMessage()` function takes a new message as input. It replaces the previous message and then stores `msg.sender` as the new last editor.

```solidity
message = newMessage;
lastEditor = msg.sender;
```

Using `msg.sender` means the contract automatically gets the address of the account calling the function. The caller does not have to provide their address manually.

I also created separate read functions, `retrieveMessage()` and `retrieveLastEditor()`, which allow the stored values to be viewed without modifying the contract state.

## 3. Deployment

* **Network:** Remix VM
* **Contract:** `Storage`
* **Contract address:** [Enter your deployed contract address]
* **Transaction hash:** [Enter transaction hash if required]
* **Block explorer link:** [Enter link if applicable]

## 4. Testing the contract

I tested the contract by performing the following operations:

1. Deploy the `Storage` contract.
2. Call `retrieveMessage()` before making any update → returns an empty string.
3. Call `updateMessage("Hello")` from one account.
4. Call `retrieveMessage()` → returns `"Hello"`.
5. Call `retrieveLastEditor()` → returns the address of the account that made the update.
6. Call `updateMessage()` again with a different message.
7. Check `retrieveMessage()` → confirms that the new message replaced the previous one.
8. Check `retrieveLastEditor()` → confirms that the address corresponds to the account that performed the latest update.

## 5. Main concept I learned

The main concept I focused on in this exercise was `msg.sender`.

`msg.sender` is a Solidity global variable that identifies the address that directly called the current function. In this contract, it is used to automatically record who updated the message.

I also learned the difference between functions that modify blockchain state and `view` functions that only read stored information. The `updateMessage()` function changes the stored values, while `retrieveMessage()` and `retrieveLastEditor()` only return information.

## 6. Acknowledgements

I used AI assistance to understand Solidity state variables, function visibility, `msg.sender`, and the difference between state-changing and read-only functions. I also referred to Solidity documentation while understanding the contract structure. The final code was written, tested, and verified by me in Remix.
