// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract StringEqualityComparisonGasExample {

    function hashCompareInternal(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }

    function utilCompareInternal(string memory a, string memory b) internal pure returns (bool) {
        if (bytes(a).length != bytes(b).length) {
            return false;
        }
        for (uint256 i = 0; i < bytes(a).length; i++) {
            if (bytes(a)[i] != bytes(b)[i]) {
                return false;
            }
        }
        return true;
    }

    function hashCompareWithLengthCheckInternal(string memory a, string memory b) internal pure returns (bool) {
        if (bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(bytes(a)) == keccak256(bytes(b));
        }
    }

    function hashCompare(string memory a, string memory b) public pure returns (bool) {
        return hashCompareInternal(a, b);
    }

    function utilCompare(string memory a, string memory b) public pure returns (bool) {
        return utilCompareInternal(a, b);
    }

    function hashCompareWithLengthCheck(string memory a, string memory b) public pure returns (bool) {
        return hashCompareWithLengthCheckInternal(a, b);
    }
}
