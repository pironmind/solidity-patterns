// This code contains deliberate errors. Do not use.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract BadAuction {

    address highestBidder;
    uint256 highestBid;

    function bid() public payable {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            payable(highestBidder).transfer(highestBid);
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }
}
