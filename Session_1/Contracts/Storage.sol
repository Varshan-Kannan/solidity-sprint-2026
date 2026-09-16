// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & update a message and record the last editor
 */
contract Storage {

    string message;
    address lastEditor;

    // AI-assisted: Function to update the message
    // and record the address of the person who updated it
    function updateMessage(string memory newMessage) public {
        message = newMessage;
        lastEditor = msg.sender;
    }

    function retrieveMessage() public view returns (string memory) {
        return message;
    }

    function retrieveLastEditor() public view returns (address) {
        return lastEditor;
    }
}S