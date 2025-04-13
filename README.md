# NftSaleTP

NFT sale system implemented on Polygon Amoy testnet.
a GrendyCard NFT collection can be purchase using a custom EUR token.

## Overview
This project contains the following components : 
- A GrendyCard collection (ERC721)
- A custom EUR token with 4 decimals (ERC20)
- A market contract that manages the sale of GrendyCard using EUR tokens

## Contract addresses
### Polygon Ammoy Testnet
- GrendyCard contract : 0x320eb0cc902dbf6971ae8d8780eb6eb178a6d0b2
- EUR contract : 0x1bc52d99fbfa70a2f7ce4f8865927e13c0793e93
- Market contract : 0xbdfc768f6c88b469f92435d2e30e1dab895b66d1

## Features
### EUR Token (ERC20)
- Custom EUR token with 4 decimal places
- Used as the payment token for purchasing Magic NFTs
- Simple minting functionality for testing purposes

### GrendyCard NFT (ERC721)
- Unique NFTs that can be purchased through the Market
- Controlled minting system where only the Market contract can mint tokens
- Sequential token IDs starting from 0

### Marker contract
- Manages the sale of GrendyCard NFts using EUR tokens

## Technical Details
### Contract Deployment
- Network : Polygon Amoy Testnet
- Block : EUR: 20398437 / GrendyCard: 20398508 / Market: 20398970
- Average Gas Price : 45 Gwei
- Total Cost : 135 Gwei

### Transaction Hashes
- GrendyCard NFT Deployment: 0x1c9aa76de896bba3d787432eff1a3c7f6a9ce7710b0a9b9636b699e989cd3ae3
- EUR Token Deployment: 0x4cad192e4fddfbac4ed874b8298cb6ad5365662461658ac00f8cc80343af77cc
- Market Contract Deployment: 0xbe893e82699d77478b1530eed225ec462d05704b96a3ec7d994f293b085c44d5

## Development
This project is built using :
- Solidity ^0.8.0
- OpenZeppelin Contracts
- Foundry for development and testing

## License
UNLICENSED