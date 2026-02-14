// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @notice Transient Storage pattern example.
/// @dev Uses EIP-1153 opcodes (TSTORE/TLOAD) via inline assembly.
///
/// Key safety rule:
/// - Because transient storage is cleared at the *end of the transaction* (not per call frame),
///   values can leak across multiple invocations in a complex transaction.
/// - Safe usage typically means: set transient state at the beginning of a call and clear it
///   before returning (e.g., for reentrancy guards).
///
/// Requirements:
/// - Must compile for a Prague/Cancun-compatible EVM (your Hardhat config uses evmVersion).
/// - Network support depends on the chain/L2.
contract TransientStorage {
    // IMPORTANT: Inline assembly only supports *literal* constants for tload/tstore slots.
    // Pick arbitrary fixed slots for educational examples.
    uint256 internal constant _VALUE_SLOT = 0xBEEF;
    uint256 internal constant _LOCK_SLOT = 0xBEEE;

    function setTemp(uint256 value) external {
        assembly {
            //
            tstore(_VALUE_SLOT, value)
        }
    }

    function getTemp() external view returns (uint256 value) {
        assembly {
            value := tload(_VALUE_SLOT)
        }
    }

    function clearTemp() external {
        assembly {
            tstore(_VALUE_SLOT, 0)
        }
    }

    /// @notice Example that uses transient state and clears it before returning.
    function setTempAndReturn(uint256 value) external returns (uint256 readBack) {
        assembly {
            tstore(_VALUE_SLOT, value)
            readBack := tload(_VALUE_SLOT)
            tstore(_VALUE_SLOT, 0)
        }
    }

    /// @notice Example of a transient-storage reentrancy lock.
    /// @dev This pattern is composability-safe if the lock is always cleared before returning.
    function guardedIncrement(uint256 x) external returns (uint256) {
        // lock
        assembly {
            if tload(_LOCK_SLOT) { revert(0, 0) }
            tstore(_LOCK_SLOT, 1)
        }

        // work (dummy)
        uint256 y = x + 1;

        // unlock
        assembly {
            tstore(_LOCK_SLOT, 0)
        }
        return y;
    }
}
