# RBAC roles

## Intent

Use role-based access control (RBAC) to restrict access to sensitive actions using **roles** instead of a single owner.

## Motivation

Modern protocols frequently need multiple permission tiers (admin, minter, pauser, upgrader). RBAC provides:
- principle of least privilege
- separation of duties
- safer operational controls

## Sample Code

See `contracts/AccessControl/RBAC.sol`.

[**< Back**](https://fravoll.github.io/solidity-patterns/)

