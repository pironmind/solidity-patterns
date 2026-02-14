// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract MemoryArrayBuildingCheap {

    struct Item {
        string name;
        string category;
        address owner;
        uint32 zipcode;
        uint32 price;
    }

    Item[] public items;

    mapping(address => uint256) public ownerItemCount;

    function getItemsbyOwner(address _owner) public view returns (uint256[] memory) {
        uint256[] memory result = new uint256[](ownerItemCount[_owner]);

        uint256 counter = 0;
        for (uint256 i = 0; i < items.length; i++) {
            if (items[i].owner == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function initialize() public {
        // Hardhat local network default accounts (deterministic).
        // See: https://hardhat.org/hardhat-network/docs/reference#accounts
        address a1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        address a2 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

        Item memory tempItem = Item("test1", "house", a1, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a1]++;

        tempItem = Item("test2", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test3", "house", a1, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a1]++;

        tempItem = Item("test4", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test5", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test6", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test7", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test8", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test9", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test10", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;
    }
}

contract MemoryArrayBuildingExpensive {

    struct Item {
        string name;
        string category;
        address owner;
        uint32 zipcode;
        uint32 price;
    }

    Item[] public items;

    mapping(address => uint256) public ownerItemCount;

    function getItemsbyOwner(address _owner) public view returns (uint256[] memory) {
        uint256[] memory result = new uint256[](ownerItemCount[_owner]);

        uint256 counter = 0;
        for (uint256 i = 0; i < items.length; i++) {
            if (items[i].owner == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function initialize() public {
        // Hardhat local network default accounts (deterministic).
        address a1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        address a2 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

        Item memory tempItem = Item("test1", "house", a1, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a1]++;

        tempItem = Item("test2", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test3", "house", a1, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a1]++;

        tempItem = Item("test4", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test5", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test6", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test7", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test8", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test9", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;

        tempItem = Item("test10", "house", a2, 80331, 212);
        items.push(tempItem);
        ownerItemCount[a2]++;
    }
}
