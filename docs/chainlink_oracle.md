# Oracle (Chainlink feeds, staleness checks)

## Intent

Fetch off-chain data from a decentralized oracle network using Chainlink Data Feeds, with basic checks for correctness and freshness.

## Motivation

When using a feed answer on-chain, you typically should verify:
- `updatedAt != 0` (answer exists)
- `answeredInRound >= roundId` (round not incomplete)
- answer age is within an acceptable threshold (staleness)

## Sample Code

See `contracts/Oracle/ChainlinkPriceFeedOracle.sol`.

[**< Back**](https://fravoll.github.io/solidity-patterns/)

