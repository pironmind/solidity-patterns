# Custom Errors

## Intent

Use **custom errors** (`error X(...)`) instead of revert strings to reduce gas costs and provide structured, ABI-decodable revert reasons.

## Motivation

Revert strings are convenient but expensive because the string data is stored in the deployed bytecode and returned on revert.

Since Solidity 0.8.4, custom errors allow you to:
- encode structured data (addresses, amounts, etc.)
- reduce deployment/runtime costs
- decode errors off-chain or in tests

## Applicability

Use custom errors when:
- you have frequently-hit require checks
- you want structured failure data
- you maintain a consistent error catalog across contracts

## Sample Code

See `contracts/CustomErrors/CustomErrors.sol`.

[**< Back**](https://fravoll.github.io/solidity-patterns/)

