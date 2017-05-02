pragma solidity ^0.4.8;

import "./NormCorpusInterface.sol";

contract NormCorpusProxy {
    NormCorpusInterface instance;
    address public owner;

    function NormCorpusProxy(NormCorpusInterface _instance) {
        owner = msg.sender;
        instance = _instance;
    }

    function setInstance(NormCorpusInterface _instance) {
        if (msg.sender != owner) throw;
        instance = _instance;
    }

    function getInstance() public constant returns (NormCorpusInterface) {
        return instance;
    }
}
