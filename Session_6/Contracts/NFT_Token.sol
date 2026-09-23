// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DigitalCollection is ERC721URIStorage, Ownable {

    uint256 private nextTokenId;

    constructor()
        ERC721("Digital Collection", "DGC")
        Ownable(msg.sender)
    {}

    // Creates a new NFT and assigns it to the contract owner
    function createNFT(string calldata metadataURI)
        public
        onlyOwner
        returns (uint256)
    {
        uint256 newId = ++nextTokenId;

        _safeMint(owner(), newId);
        _setTokenURI(newId, metadataURI);

        return newId;
    }

    // Returns the number of NFTs created
    function mintedCount() public view returns (uint256) {
        return nextTokenId;
    }
}