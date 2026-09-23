// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MiniNFT {
    string public name = 'Mini NFT';
    string public symbol = "MNFT";
    uint256 public tokenId;

    mapping (address=>uint256) balanceOf;
    mapping (uint256=>address) ownerOf;
    mapping (uint256=>string) tokenURI;

    event Mint(address minter, uint256 _tokenId);
    event Transfer(address sender, address receiver, uint256 _tokenId);

    function mint(string memory _uri) external returns (bool){
        tokenId++;
        uint256 _tokenId = tokenId;
        // _tokenId++;

        balanceOf[msg.sender] += 1;
        ownerOf[_tokenId] = msg.sender;
        tokenURI[_tokenId] = _uri;

        emit Mint(msg.sender, _tokenId);
        return true;
    }

    function transfer(address _to, uint256 _tokenId) external {
        require(balanceOf[msg.sender] > 0, "Zero Balance");
        require(_to != address(0), "Zero Address");
        require(ownerOf[_tokenId] == msg.sender, "No permission to Transfer");

        ownerOf[_tokenId] = _to;
        balanceOf[msg.sender] -= 1;
        balanceOf[_to] += 1;

        emit Transfer(msg.sender, _to, _tokenId);
    }
}