# Solidity Patterns

This document contains a collection of design and programming patterns for the smart contract programming language Solidity in version 0.4.20. Note that newer versions might have changed some of the functionalities.
Each pattern consists of a code sample and a detailed explanation, including background, implications and additional information about the patterns.

## Contents


* **Behavioral Patterns**
  * [**Guard Check**](./guard_check.md): Ensure that the behavior of a smart contract and its input parameters are as expected.
  * [**State Machine**](./state_machine.md): Enable a contract to go through different stages with different corresponding functionality exposed.
  * [**Oracle**](./oracle.md): Gain access to data stored outside of the blockchain.
  * [**Randomness**](./randomness.md): Generate a random number of a predefined interval in the deterministic environment of a blockchain.
* **Security Patterns**
  * [**Access Restriction**](./access_restriction.md): Restrict the access to contract functionality according to suitable criteria.
  * [**Checks Effects Interactions**](./checks_effects_interactions.md): Reduce the attack surface for malicious contracts trying to hijack control flow after an external call.
  * [**Secure Ether Transfer**](./secure_ether_transfer.md): Secure transfer of ether from a contract to another address.
  * [**Pull over Push**](./pull_over_push.md): Shift the risk associated with transferring ether to the user.
  * [**Emergency Stop**](./emergency_stop.md): Add an option to disable critical contract functionality in case of an emergency.
* **Upgradeability Patterns**
  * [**Proxy Delegate**](./proxy_delegate.md): Introduce the possibility to upgrade smart contracts without breaking any dependencies.
  * [**Eternal Storage**](./eternal_storage.md): Keep contract storage after a smart contract upgrade.
* **Economic Patterns**
  * [**String Equality Comparison**](./string_equality_comparison.md): Check for the equality of two provided strings in a way that minimizes average gas consumption for a large number of different inputs.
  * [**Tight Variable Packing**](./tight_variable_packing.md): Optimize gas consumption when storing or loading statically-sized variables.
  * [**Memory Array Building**](./memory_array_building.md): Aggregate and retrieve data from contract storage in a gas efficient way.

* **Modern Solidity & EVM Patterns (0.8.x+)**
  * [**Custom Errors**](./custom_errors.md): Use custom errors instead of revert strings for cheaper, structured reverts.
  * [**Transient Storage (EIP-1153)**](./transient_storage.md): Use per-transaction storage for temporary state without persistent `SSTORE` costs.
  * [**Two-step ownership**](./two_step_ownership.md): Propose + accept ownership transfer to avoid accidental ownership loss.
  * [**RBAC roles**](./rbac_roles.md): Role-based access control for multi-role permissioning.
  * [**EIP-712 permits**](./eip712_permit.md): Gasless approvals using typed signatures and nonces.
  * [**Upgradeability (EIP-1967 / UUPS)**](./uups_eip1967.md): Standard proxy slots and UUPS authorization.
  * [**Oracle (Chainlink feeds)**](./chainlink_oracle.md): Data feeds with staleness/incomplete-round checks.
  * [**Randomness (VRF)**](./vrf_randomness.md): Verifiable randomness callback pattern.

## Bibliography

The sources used in this document can be found in this [bibliography](./bibliography.md).

## Disclaimer

This repository is not under active development anymore and some (if not most) sections might be outdated. There is no liability for any damages caused by the use of one of these patterns.
