# Session 02

Create a student record contract using structs, enums, and mappings.

**Name:** Varshan R K
**Enrolment ID:** AU24UG040
**Date submitted:** 16/09/2026

## Contract

* `StudentRecord.sol`

## 1. Purpose of the contract

The `StudentRecord` contract is designed to store basic information about students. Each record contains the student's name, enrolment ID, and current academic status.

The contract supports three possible statuses:

* `Active`
* `Inactive`
* `Graduated`

A student address is used as the key for storing and retrieving each record.

## 2. How the contract is structured

I used an `enum` called `Status` to define the three possible student states instead of storing the status as a normal number.

```solidity
enum Status {
    Active,
    Inactive,
    Graduated
}
```

I then created a `Student` struct containing all the information associated with one student:

```solidity
struct Student {
    string name;
    uint256 enrolmentId;
    Status status;
}
```

The records are stored using:

```solidity
mapping(address => Student) public students;
```

This allows a student's wallet address to be associated directly with their record.

A separate Boolean mapping is also used:

```solidity
mapping(address => bool) public isRegistered;
```

This keeps track of whether an address has already been registered.

## 3. Registering a student

The `registerStudent()` function receives the student's address, name, and enrolment ID.

Before creating a record, the contract checks:

```solidity
require(
    !isRegistered[studentAddress],
    "Student already registered"
);
```

This prevents the same address from being registered more than once.

A newly registered student is automatically given the `Active` status:

```solidity
students[studentAddress] = Student(
    name,
    enrolmentId,
    Status.Active
);
```

The address is then marked as registered in the Boolean mapping.

## 4. Changing student status

The `updateStatus()` function allows the status of an existing student record to be changed.

Before making the update, the contract verifies that the address belongs to a registered student:

```solidity
require(
    isRegistered[studentAddress],
    "Student not registered"
);
```

If the address is valid, the stored status is replaced with the new status.

## 5. Retrieving student information

The `getStudent()` function is used to read a student's information.

It first checks whether the supplied address has been registered. If the address is not registered, the transaction is rejected.

For a registered student, the function returns:

* Student name
* Enrolment ID
* Current status

The function uses a temporary `Student memory` variable to access the stored record before returning its values.

## 6. Deployment

* **Network:** Remix VM
* **Contract:** `StudentRecord`
* **Contract address:** [Enter your deployed con]()
