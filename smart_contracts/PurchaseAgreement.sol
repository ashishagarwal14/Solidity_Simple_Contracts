// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

//adding security protocol ReentracyGuard in contract to defend from reentrancy attack
contract PurchaseAgreement is ReentrancyGuard{
    // payable address of buyer, seller
    address payable public buyer;
    address payable public seller;
    // value of the item and item description
    uint public value;
    string public Item;

    // enum to create and keep track of the contract state to grant access permission
    enum State { Created, Locked, Released, Inactive }
    
    State public state;

    constructor(string memory item_discription) payable {
        state = State.Created;
        value = msg.value / 2;
        Item = item_discription;
        seller = payable(msg.sender);
    }

    /// This contract is in different state, unathorized attempt to access
    error InvalidState();

    /// Only buyer has access to this, unathorized attempt to access
    error OnlyBuyer();

    /// Only seller has access to this, unathorized attempt to access
    error OnlySeller();

    // modifer to check the current state of the contract to given state_
    modifier checkState(State state_) {
        if(state != state_){
            revert InvalidState();
        }

        _;
    }

    // modifer to check the current sender address is buyer's address
    modifier onlyBuyer() {
        if(msg.sender != buyer){
            revert OnlyBuyer();
        }

        _;
    }

    // modifer to check the current sender address is buyer's address
    modifier onlySeller() {
        if(msg.sender != seller){
            revert OnlySeller();
        }

        _;
    }

    // to confirm the purchase and assign sender's address to buyer 
    function confirmPurchase() external payable checkState(State.Created) {
        require(msg.value == 2 * value, 'Please send 2 times the Purchase value, you will '
        'be returned the deposit once you confirmRecieve');
        state = State.Locked;
        buyer = payable(msg.sender);
    }

    // to confirm the item is received by the buyer, transfer the deposit to buyer
    function confirmReceive() external onlyBuyer checkState(State.Locked) nonReentrant {
        state = State.Released;
        buyer.transfer(value);
    }

    // pay the seller current contract's balance and close the contract to Inactive state 
    function paySeller() external onlySeller checkState(State.Released) nonReentrant  {
        state = State.Inactive;
        seller.transfer(address(this).balance);
    }

    // get the current balance of the contract
    function getbalance() external view returns( uint) {
        return address(this).balance;
    }

    // for seller to abort the contract, if the purchase in not made
    function abortContract() external onlySeller checkState(State.Created) {
        state = State.Inactive;
        seller.transfer(address(this).balance);
    }
}

