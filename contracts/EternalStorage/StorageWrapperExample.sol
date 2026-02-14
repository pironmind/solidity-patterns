// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {EternalStorage} from "./EternalStorage.sol";

/// @notice Minimal wrapper example showing how to use EternalStorage keys.
/// @dev This file used to be a snippet; it's now a tiny contract so Hardhat can compile it.
contract StorageWrapperExample {
    EternalStorage public immutable eternalStorageAdr;

    constructor(address _eternalStorage) {
        require(_eternalStorage != address(0), "storage=0");
        eternalStorageAdr = EternalStorage(_eternalStorage);
    }

    function getBalance(address balanceHolder) public view returns (uint256) {
        return eternalStorageAdr.getUint(keccak256(abi.encodePacked("balances", balanceHolder)));
    }

    function setBalance(address balanceHolder, uint256 amount) public {
        // In a real system you'd restrict this. It's public here to keep the example short.
        eternalStorageAdr.setUint(keccak256(abi.encodePacked("balances", balanceHolder)), amount);
    }

    function addBalance(address balanceHolder, uint256 amount) external {
        setBalance(balanceHolder, getBalance(balanceHolder) + amount);
    }
}
