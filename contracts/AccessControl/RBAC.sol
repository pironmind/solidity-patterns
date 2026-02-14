// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @notice Minimal RBAC (role-based access control) pattern.
/// @dev Educational (not OpenZeppelin). Demonstrates roles, admin roles, and events.
contract RBAC {
    error MissingRole(bytes32 role, address account);
    error MissingAdminRole(bytes32 adminRole, address account);

    // Common convention: DEFAULT_ADMIN_ROLE is 0x00
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    mapping(bytes32 role => mapping(address account => bool)) private _hasRole;
    mapping(bytes32 role => bytes32) private _roleAdmin;

    event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setRoleAdmin(DEFAULT_ADMIN_ROLE, DEFAULT_ADMIN_ROLE);
    }

    modifier onlyRole(bytes32 role) {
        if (!_hasRole[role][msg.sender]) revert MissingRole(role, msg.sender);
        _;
    }

    function hasRole(bytes32 role, address account) external view returns (bool) {
        return _hasRole[role][account];
    }

    function getRoleAdmin(bytes32 role) external view returns (bytes32) {
        bytes32 admin = _roleAdmin[role];
        // if not explicitly set, default to DEFAULT_ADMIN_ROLE
        return admin == bytes32(0) ? DEFAULT_ADMIN_ROLE : admin;
    }

    function grantRole(bytes32 role, address account) external {
        bytes32 adminRole = this.getRoleAdmin(role);
        if (!_hasRole[adminRole][msg.sender]) revert MissingAdminRole(adminRole, msg.sender);
        _grantRole(role, account);
    }

    function revokeRole(bytes32 role, address account) external {
        bytes32 adminRole = this.getRoleAdmin(role);
        if (!_hasRole[adminRole][msg.sender]) revert MissingAdminRole(adminRole, msg.sender);
        _revokeRole(role, account);
    }

    function renounceRole(bytes32 role) external {
        _revokeRole(role, msg.sender);
    }

    function setRoleAdmin(bytes32 role, bytes32 adminRole) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _setRoleAdmin(role, adminRole);
    }

    function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal {
        bytes32 prev = _roleAdmin[role];
        if (prev == bytes32(0)) prev = DEFAULT_ADMIN_ROLE;
        _roleAdmin[role] = adminRole;
        emit RoleAdminChanged(role, prev, adminRole);
    }

    function _grantRole(bytes32 role, address account) internal {
        if (_hasRole[role][account]) return;
        _hasRole[role][account] = true;
        emit RoleGranted(role, account, msg.sender);
    }

    function _revokeRole(bytes32 role, address account) internal {
        if (!_hasRole[role][account]) return;
        _hasRole[role][account] = false;
        emit RoleRevoked(role, account, msg.sender);
    }
}

