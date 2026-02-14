# EIP-712 signatures / permits

## Intent

Allow off-chain approvals via signatures (gasless approvals) using **EIP-712 typed structured data**, typically in the form of an ERC-2612 `permit()` function.

## Motivation

Permits improve UX by letting a user sign an approval off-chain, while a relayer (or the spender) submits the transaction on-chain.

Core requirements:
- Domain separation (chainId + verifyingContract)
- Nonce per owner
- Deadline
- Strict signature recovery checks

## Sample Code

See `contracts/Signatures/EIP712PermitToken.sol`.

[**< Back**](https://fravoll.github.io/solidity-patterns/)

