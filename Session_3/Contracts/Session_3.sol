// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IStudentRecord {

    function getStudent(address studentAddress)
        external
        view
        returns (
            string memory,
            uint256,
            uint8
        );
}

contract StudentRecord is IStudentRecord, Ownable {

    enum Status {
        Active,
        Inactive,
        Graduated
    }

    struct Student {
        string name;
        uint256 enrolmentId;
        Status status;
    }

    event Registered(string name, uint256 enrolmentId);
    event update(Status newStatus);

    mapping(address => Student) public students;
    mapping(address => bool) public isRegistered;

    modifier Alreadyregistered(address studentaddress) {

        require(
            !isRegistered[studentaddress],
            "Student already registered"
        );

        _;
    }

    constructor() Ownable(msg.sender) {}

    // Asked AI for help to understand the code and logic
    function registerStudent(
        address studentAddress,
        string memory name,
        uint256 enrolmentId
    )
        public
        Alreadyregistered(studentAddress)
    {
        students[studentAddress] = Student(
            name,
            enrolmentId,
            Status.Active
        );

        isRegistered[studentAddress] = true;

        emit Registered(name, enrolmentId);
    }

    function updateStatus(
        address studentAddress,
        Status newStatus
    )
        public
        onlyOwner
    {
        require(
            isRegistered[studentAddress],
            "Student not registered"
        );

        students[studentAddress].status = newStatus;

        emit update(newStatus);
    }

    function getStudent(
        address studentAddress
    )
        public
        view
        override
        returns (
            string memory,
            uint256,
            uint8
        )
    {
        require(
            isRegistered[studentAddress],
            "Student not registered"
        );

        Student memory student = students[studentAddress];

        return (
            student.name,
            student.enrolmentId,
            uint8(student.status)
        );
    }
}