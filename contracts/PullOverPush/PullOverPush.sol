// This code has not been professionally audited, therefore I cannot make any promises about
// safety or correctness. Use at own risk.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract PullOverPush {

    mapping(address => uint256) credits;

    function allowForPull(address receiver, uint256 amount) private {
        credits[receiver] += amount;
    }

    function withdrawCredits() public {
        uint256 amount = credits[msg.sender];

        require(amount != 0);
        require(address(this).balance >= amount);

        credits[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
    }
}
