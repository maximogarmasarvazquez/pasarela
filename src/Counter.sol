// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    error NotOwner(address caller);
    error MaxReached(uint256 current);

    event NumberSet(address indexed by, uint256 oldValue, uint256 newValue);

    uint256 public constant MAX_NUMBER = 100;

    uint256 public number;
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    function setNumber(uint256 newNumber) public {
        if (msg.sender != owner) {
            revert NotOwner(msg.sender);
        }

        uint256 oldValue = number;
        number = newNumber;

        emit NumberSet(msg.sender, oldValue, newNumber);
    }

    function increment() public {
        uint256 current = number;

        if (current >= MAX_NUMBER) {
            revert MaxReached(current);
        }

        number = current + 1;

        emit NumberSet(msg.sender, current, current + 1);
    }
}
