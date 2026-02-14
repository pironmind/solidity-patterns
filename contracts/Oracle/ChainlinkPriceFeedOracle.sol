// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {AggregatorV3Interface} from "./AggregatorV3Interface.sol";

/// @notice Chainlink Data Feed oracle wrapper with staleness checks.
contract ChainlinkPriceFeedOracle {
    error FeedIsZero();
    error StaleAnswer();
    error IncompleteRound();
    error AnswerTooOld(uint256 updatedAt, uint256 nowTs, uint256 maxAge);

    AggregatorV3Interface public immutable feed;
    uint256 public immutable maxAnswerAge;

    constructor(address _feed, uint256 _maxAnswerAge) {
        if (_feed == address(0)) revert FeedIsZero();
        feed = AggregatorV3Interface(_feed);
        maxAnswerAge = _maxAnswerAge;
    }

    function latestRoundDataSafe()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 updatedAt, uint8 decimals)
    {
        (uint80 _roundId, int256 _answer, , uint256 _updatedAt, uint80 answeredInRound) = feed.latestRoundData();

        if (_updatedAt == 0) revert StaleAnswer();
        if (answeredInRound < _roundId) revert IncompleteRound();
        if (maxAnswerAge != 0 && block.timestamp - _updatedAt > maxAnswerAge) {
            revert AnswerTooOld(_updatedAt, block.timestamp, maxAnswerAge);
        }

        return (_roundId, _answer, _updatedAt, feed.decimals());
    }
}

