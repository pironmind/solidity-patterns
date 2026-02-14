// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @notice Minimal interface matching Chainlink VRF v2+ callback shape.
interface IVRFConsumerLike {
    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) external;
}

/// @notice Educational VRF consumer *shape* (not wired to real Chainlink coordinator).
/// @dev This repo avoids network-specific dependencies; this contract shows the pattern:
/// - request randomness
/// - coordinator callback (fulfillment)
/// - store result + freshness metadata
contract VRFConsumerLike {
    error OnlyCoordinator(address caller);

    address public immutable coordinator;

    uint256 public lastRequestId;
    uint256 public lastRandomWord;
    uint256 public lastFulfilledAt;

    event RandomnessRequested(uint256 indexed requestId);
    event RandomnessFulfilled(uint256 indexed requestId, uint256 randomWord);

    constructor(address _coordinator) {
        coordinator = _coordinator;
    }

    /// @notice In real usage, this would call the VRF coordinator.
    /// @dev Here we just emit an event and increment a request id.
    function requestRandomness() external returns (uint256 requestId) {
        requestId = ++lastRequestId;
        emit RandomnessRequested(requestId);
    }

    /// @notice Coordinator callback.
    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) external {
        if (msg.sender != coordinator) revert OnlyCoordinator(msg.sender);
        lastRandomWord = randomWords[0];
        lastFulfilledAt = block.timestamp;
        emit RandomnessFulfilled(requestId, randomWords[0]);
    }
}

/// @notice Tiny mock coordinator to demo/locally test the flow.
contract VRFCoordinatorMock {
    function fulfill(address consumer, uint256 requestId, uint256 randomWord) external {
        uint256[] memory words = new uint256[](1);
        words[0] = randomWord;
        IVRFConsumerLike(consumer).fulfillRandomWords(requestId, words);
    }
}

