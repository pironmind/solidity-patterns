// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @notice Minimal UUPS-style upgradeability components (EIP-1967).
/// @dev Educational only. Not production-ready.
abstract contract ERC1967Upgrade {
    // keccak256("eip1967.proxy.implementation") - 1
    bytes32 internal constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    event Upgraded(address indexed implementation);

    function _getImplementation() internal view returns (address impl) {
        assembly {
            impl := sload(_IMPLEMENTATION_SLOT)
        }
    }

    function _setImplementation(address newImplementation) internal {
        assembly {
            sstore(_IMPLEMENTATION_SLOT, newImplementation)
        }
    }

    function _upgradeTo(address newImplementation) internal {
        _setImplementation(newImplementation);
        emit Upgraded(newImplementation);
    }
}

abstract contract UUPSUpgradeable is ERC1967Upgrade {
    error UnauthorizedUpgrade(address caller);

    /// @notice Must revert unless caller is allowed to upgrade.
    function _authorizeUpgrade(address newImplementation) internal virtual;

    /// @notice Upgrade implementation. Must be called through proxy (delegatecall).
    function upgradeTo(address newImplementation) external {
        _authorizeUpgrade(newImplementation);
        _upgradeTo(newImplementation);
    }
}

/// @notice Minimal EIP-1967 proxy.
contract ERC1967Proxy {
    // keccak256("eip1967.proxy.implementation") - 1
    bytes32 private constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    constructor(address implementation, bytes memory initData) payable {
        assembly {
            sstore(_IMPLEMENTATION_SLOT, implementation)
        }

        if (initData.length != 0) {
            (bool ok, bytes memory err) = implementation.delegatecall(initData);
            require(ok, string(err));
        }
    }

    fallback() external payable {
        _delegate();
    }

    receive() external payable {
        _delegate();
    }

    function _delegate() internal {
        assembly {
            let impl := sload(_IMPLEMENTATION_SLOT)
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}

/// @notice Example UUPS implementation.
contract CounterV1 is UUPSUpgradeable {
    uint256 public value;
    address public owner;

    event Initialized(address indexed owner);

    modifier onlyOwner() {
        if (msg.sender != owner) revert UnauthorizedUpgrade(msg.sender);
        _;
    }

    function initialize(address _owner) external {
        // minimal initializer guard:
        require(owner == address(0), "already init");
        owner = _owner;
        emit Initialized(_owner);
    }

    function inc() external {
        value += 1;
    }

    function _authorizeUpgrade(address) internal view override onlyOwner {
        // onlyOwner enforced
    }
}

contract CounterV2 is CounterV1 {
    function dec() external {
        value -= 1;
    }
}
