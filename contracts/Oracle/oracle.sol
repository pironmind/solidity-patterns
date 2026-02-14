// This code has not been professionally audited, therefore I cannot make any promises about
// safety or correctness. Use at own risk.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {AggregatorV3Interface} from "./AggregatorV3Interface.sol";

/// @notice Oracle pattern example using a Chainlink Data Feed (pull model).
/// @dev This replaces the legacy Oraclize example, which relied on an external GitHub import.
contract Oracle {
    AggregatorV3Interface public immutable feed;

    /// @dev The maximum age (in seconds) that we consider the answer "fresh".
    uint256 public immutable maxAnswerAge;

    constructor(address _feed, uint256 _maxAnswerAge) {
        require(_feed != address(0), "feed=0");
        feed = AggregatorV3Interface(_feed);
        maxAnswerAge = _maxAnswerAge;
    }

    /// @notice Reads latest answer from the feed with basic safety checks.
    /// @return answer Latest answer from the feed.
    /// @return updatedAt Timestamp when the answer was last updated.
    function latestAnswer() external view returns (int256 answer, uint256 updatedAt) {
        (
            uint80 roundId,
            int256 _answer,
            ,
            uint256 _updatedAt,
            uint80 answeredInRound
        ) = feed.latestRoundData();

        // Basic validity checks recommended by Chainlink.
        require(_updatedAt != 0, "stale");
        require(answeredInRound >= roundId, "incomplete");
        require(maxAnswerAge == 0 || block.timestamp - _updatedAt <= maxAnswerAge, "too old");

        return (_answer, _updatedAt);
    }
}
