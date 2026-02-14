// This code has not been professionally audited, therefore I cannot make any promises about
// safety or correctness. Use at own risk.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract EtherReceiver {
    receive() external payable {}
}

contract EtherSender {

    EtherReceiver private receiverAdr = new EtherReceiver();

    function sendEther(uint256 _amount) public payable {
        // `send` forwards 2300 gas and returns false on failure (legacy pattern).
        if (!payable(address(receiverAdr)).send(_amount)) {
            // handle failed send
        }
    }

    function callValueEther(uint256 _amount) public payable {
        // Modern call syntax (can forward configurable gas).
        (bool ok, ) = payable(address(receiverAdr)).call{value: _amount, gas: 21_000}("");
        require(ok);
    }

    function transferEther(uint256 _amount) public payable {
        // `transfer` forwards 2300 gas and reverts on failure (legacy pattern).
        payable(address(receiverAdr)).transfer(_amount);
    }
}
