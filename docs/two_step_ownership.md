# Two-step ownership

## Intent

Prevent accidental or unsafe ownership transfers by requiring the new owner to **accept** ownership.

## Motivation

A direct `transferOwnership(newOwner)` can permanently lock a protocol if the new owner address is wrong, an EOA is lost, or a contract doesn’t implement required admin methods.

Two-step ownership mitigates this by splitting the transfer into:
1. Current owner proposes a `pendingOwner`
2. `pendingOwner` calls `acceptOwnership()`

## Sample Code

See `contracts/AccessControl/TwoStepOwnable.sol`.

[**< Back**](https://fravoll.github.io/solidity-patterns/)

