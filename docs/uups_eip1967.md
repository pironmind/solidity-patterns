# Upgradeability (EIP-1967 / UUPS)

## Intent

Enable safe implementation upgrades by separating storage (proxy) from logic (implementation), using standardized storage slots (EIP-1967) and UUPS authorization.

## Motivation

Proxies allow upgrades while keeping the same address and storage. UUPS (Universal Upgradeable Proxy Standard) moves upgrade logic into the implementation and relies on:
- EIP-1967 implementation slot
- explicit authorization in `_authorizeUpgrade()`
- initializer instead of constructor

## Sample Code

See `contracts/Upgradeability/UUPSMinimal.sol`.

[**< Back**](https://fravoll.github.io/solidity-patterns/)

