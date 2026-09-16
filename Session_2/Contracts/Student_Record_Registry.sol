// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @title Student Record
 * @dev Store and manage student records
 */
contract StudentRecord {

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

    mapping(address => Student) public students;
    mapping(address => bool) public isRegistered;

    // AI-assisted: Registration, validation and status update logic
    function registerStudent(
        address studentAddress,
        string memory name,
        uint256 enrolmentId
    ) public {

        require(
            !isRegistered[studentAddress],
            "Student already registered"
        );

        students[studentAddress] = Student(
            name,
            enrolmentId,
            Status.Active
        );

        isRegistered[studentAddress] = true;
    }

    function updateStatus(
        address studentAddress,
        Status newStatus
    ) public {

        require(
            isRegistered[studentAddress],
            "Student not registered"
        );

        students[studentAddress].status = newStatus;
    }

    function getStudent(
        address studentAddress
    ) public view returns (
        string memory,
        uint256,
        Status
    ) {

        require(
            isRegistered[studentAddress],
            "Student not registered"
        );

        Student memory student = students[studentAddress];

        return (
            student.name,
            student.enrolmentId,
            student.status
        );
    }
}