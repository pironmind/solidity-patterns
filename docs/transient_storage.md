# Transient Storage

## Intent

Use **transient storage** (EIP-1153) to store ephemeral values that only need to exist **within a single transaction**, without paying the full cost of persistent storage writes.

## Motivation

Classic Solidity patterns often use contract storage for temporary state (e.g., reentrancy locks, caching, or “already processed” flags). Persistent storage (`SSTORE`) is expensive and permanently increases state size.

EIP-1153 introduces **transient storage**:
- `TSTORE` / `TLOAD` opcodes
- Scoped to the **transaction** (cleared at end of tx)
- Cheaper than persistent storage since it doesn’t touch the long-term state trie

This makes it useful for “scratchpad” values that:
- must be shared across internal calls during the same tx
- must survive across `delegatecall`/reentrancy within the same tx
- must *not* persist after the tx completes

## Applicability

Use transient storage when:
- you need a per-tx lock (reentrancy guard)
- you want to cache values during a multi-step internal flow
- you need to track temporary “visited” markers during a tx

Avoid transient storage when:
- the value must persist across transactions
- you need the value for off-chain indexing/history

## Notes & pitfalls

- **Network support**: EIP-1153 depends on the chain’s upgrade/hardfork support. Some networks/L2s may not support it yet.
- **Tx-scoped**: values are cleared at end of transaction.
- **Slot management**: treat transient slots like storage slots—avoid collisions by deriving slots from unique constants.

## Sample Code

See `contracts/TransientStorage/TransientStorage.sol`.

[**< Back**](https://fravoll.github.io/solidity-patterns/)

