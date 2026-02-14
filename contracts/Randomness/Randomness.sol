// This code has not been professionally audited, therefore I cannot make any promises about
// safety or correctness. Use at own risk.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Randomness {

    bytes32 sealedSeed;
    bool seedSet = false;
    bool betsClosed = false;
    uint256 storedBlockNumber;
    address trustedParty = 0xdCad3a6d3569DF655070DEd06cb7A1b2Ccd1D3AF;

    function setSealedSeed(bytes32 _sealedSeed) public {
        require(!seedSet);
        require(msg.sender == trustedParty);
        betsClosed = true;
        sealedSeed = _sealedSeed;
        storedBlockNumber = block.number + 1;
        seedSet = true;
    }

    function bet() public view {
        require(!betsClosed);
        // Make bets here
    }

    function reveal(bytes32 _seed) public {
        require(seedSet);
        require(betsClosed);
        require(storedBlockNumber < block.number);
        require(keccak256(abi.encodePacked(msg.sender, _seed)) == sealedSeed);
        uint256 random = uint256(keccak256(abi.encodePacked(_seed, blockhash(storedBlockNumber))));
        // Insert logic for usage of random number here;
        random; // silence unused variable warning in this snippet-style example
        seedSet = false;
        betsClosed = false;
    }
}
