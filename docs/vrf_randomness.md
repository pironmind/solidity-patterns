# Randomness (VRF)

## Intent

Generate unpredictable randomness using a verifiable randomness oracle (VRF), instead of insecure sources like block variables.

## Motivation

On-chain values like `block.timestamp`, `blockhash`, or `prevrandao` are **not sufficient** for many adversarial settings.

VRF provides:
- an on-chain proof that the random value was generated correctly
- a coordinator-driven callback (`fulfillRandomWords`) with access control

## Sample Code

See `contracts/Randomness/VRFConsumerLike.sol`.

[**< Back**](https://fravoll.github.io/solidity-patterns/)

