// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

// Claim ownership of the contract below to complete this level.

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}
