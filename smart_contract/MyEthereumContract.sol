// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
/* MyEthereumWallet is a smart contract based personal use
   wallet. Functionality includes - anyone can add to your 
   wallet, you can receive from anyone,  Only owner (address
   which deployed the contract) can send to any address or 
   withdraw from wallet to his account address. Anyone can get
   balance of wallet.
   author: <ashish.agarwal.eee14@itbhu.ac.in>
*/
/// @title   with delegation.
contract MyEthereumWallet {
    // declearation of variable to store the address of owner
    // this address needs to be payable
    address payable public walletOwner;

    // constructor executes only once, while deploying the contract
    constructor() {
        // setting owner payable address to deployer's address 
        walletOwner = payable(msg.sender);
    }

    // this function can only be accessed by the owner to transfer to any payable address
    // and any specified _amout
    function transferToAddress(address payable receiver, uint _amount) public returns (uint) {
        require( msg.sender == walletOwner, "Only wallet owner can access this" );
        (receiver).transfer(_amount);
        return _amount;
    }

    // this function can only be accessed by the owner to withdraw funds from wallet to
    // owner payable address
    function withdrawFromWallet( uint _amount) public returns (uint) {
        require(msg.sender == walletOwner, "Only wallet owner can access this.");
        (walletOwner).transfer(_amount);
        return _amount;
    }

    // returns the current wallet balance
    function getWalletBalance() external view returns (uint) {
        return address(this).balance;
    }
    
    // uncomment below function for help while testing this contract
    // function getAddressBalance() external view returns (uint) {
    //     return (msg.sender).balance;
    // }

    // Adds transferred funds to smart wallet's address, access not restricted to only the
    // owner
    function addToWallet() payable external {
        require(msg.value > 0 ether);
    }

    // this smart wallet can receive from anyone using low level interactions
    receive() external payable {}



}