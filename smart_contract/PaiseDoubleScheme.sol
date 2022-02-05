// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract PaiseDoubleScheme {
    address public owner;
    address payable[] public greedGang;
    address payable[] public doublers;
    uint public schemeId;
    mapping (uint => address payable[]) public schemeHistory;

    constructor() {
        owner = msg.sender;
        schemeId = 1;
    }

    function getWinnerByScheme(uint schemeid) public view returns (address payable[] memory) {
        return schemeHistory[schemeid];
    }

    function getSchemeBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getgreedGang() public view returns (address payable[] memory) {
        return greedGang;
    }

    function enterScheme() public payable {
        require(msg.value == 1 ether);

        // address of greedGang entering schemeId 
        greedGang.push(payable(msg.sender));
        if (greedGang.length == 4){
            pickDoublers();
        }
    }

    function getRandomNumber() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickDoublers() private{
        require(greedGang.length % 2 == 0);
        //reset the state of the doublers array
        doublers = new address payable[](0);
        uint numDoublers = greedGang.length / 2;
        uint player;
        uint index = (getRandomNumber() % greedGang.length) % 2;
        
        // uint prize = address(this).balance / numDoublers;
        for( player = index; player < greedGang.length; player+=2){
            greedGang[player].transfer(address(this).balance / numDoublers);
            doublers.push(greedGang[player]);
        }
        

        schemeHistory[schemeId] = doublers;
        schemeId++;

        //reset the state of the contract
        greedGang = new address payable[](0);
        
    }

}
