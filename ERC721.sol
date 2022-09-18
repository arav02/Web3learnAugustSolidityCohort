// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Mynft", "ABC") {}

    function CreateNFT(address owner)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newid = _tokenIds.current();
        _mint(owner, newid);//from erc721 contract

        return newid;
    }
}
