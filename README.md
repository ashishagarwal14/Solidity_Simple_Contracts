# Solidity: Simple Smart_Contracts

  # 1. "Double it or lose it" smart contract in solidity


  smart_contacts/PaiseDoubleScheme.sol
  
  How It Works : 

    Any one can enter the contest by entering amount - 1 ether. When the 4th person enters the scheme, smart contract automatically executes winner function, and randomly chooses two people as winners and transfers doubles amount, rest don't recieve anything. After every winner reveal, the contract resets and schemeId goes up by 1. you can see all previous winners using schemeId.

  This contract is not live on any mainnet, it's just for fun.

  Inspired by Lakshmi Chit Fund memes

  
  # 2. My Ethereum Wallet smart contract in solidity 
  
  
  smart_contacts/MyEthereumWallet.sol
  
  MyEthereumWallet is a smart contract based personal use wallet.
  
  Functionality includes - anyone can add to your wallet, you can receive from anyone,  Only owner (address which deployed the contract) can send to any address or withdraw from wallet to his account address. Anyone can get balance of wallet

  # 3. Purchase Agreement smart contract in solidity 
  
  
  smart_contacts/PurchaseAgreement.sol
  
  PurchaseAgreement is a smart contract based Agreenment to buy and sell real world Items using ethereum.
  
  How It Works :
  
    deployer of this smart contract will be the seller, he needs to lock 2 times the selling value in the contract as deposit and put in the Item description on the smart contract. Anyone can buy the Item by depositing twice the purchasing value, once you recieve the Item in real world, confirm received to smart contract, and the deposit will be returned to buyer. After that seller will be paid purchasing amount and his deposit amount back and contract will go in inactive state.

  example:
  
    Seller can list "Book" for 1 eth, for this seller needs to deposit 2 eth as security amount while deploying the contract, then any seller can purchase the item by depositing 2 eth, once buyer receives the item and confirm, buyer will be returned eth as security amount. After ending purchase, buyer will be returned 3 eth (security amount 2 eth + sold amount 1 eth)

  Security: 
  
     Reentrancy attack secured in contract using: @openzeppelin/contracts/security/ReentrancyGuard.sol 



# try and test out these contracts without any dependencies online on https://remix.ethereum.org/  
  
