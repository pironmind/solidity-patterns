// This code has not been professionally audited, therefore I cannot make any promises about
// safety or correctness. Use at own risk.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract AccessRestriction {

    address public owner = msg.sender;
    uint256 public lastOwnerChange = block.timestamp;

    modifier onlyBy(address _account) {
        require(msg.sender == _account);
        _;
    }

    modifier onlyAfter(uint256 _time) {
        require(block.timestamp >= _time);
        _;
    }

    modifier costs(uint256 _amount) {
        require(msg.value >= _amount);
        _;
        if (msg.value > _amount) {
            payable(msg.sender).transfer(msg.value - _amount);
        }
    }

    function changeOwner(address _newOwner) public onlyBy(owner) {
        owner = _newOwner;
    }

    function buyContract() public payable onlyAfter(lastOwnerChange + 4 weeks) costs(1 ether) {
        owner = msg.sender;
        lastOwnerChange = block.timestamp;
    }
}
