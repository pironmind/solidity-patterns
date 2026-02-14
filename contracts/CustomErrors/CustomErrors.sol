// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @notice Custom Errors pattern example.
/// @dev Custom errors are cheaper than revert strings and are ABI-decodable.
contract CustomErrors {
    error NotOwner(address caller);
    error InvalidAmount(uint256 amount);

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function onlyOwnerAction() external view returns (address) {
        if (msg.sender != owner) revert NotOwner(msg.sender);
        return owner;
    }

    function validateAmount(uint256 amount) external pure {
        if (amount == 0) revert InvalidAmount(amount);
    }
}

