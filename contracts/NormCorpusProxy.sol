pragma solidity ^0.4.8;

import "./NormCorpusInterface.sol";

contract GDAO {
    NormCorpusInterface instance;
    address public owner;

    function GDAO(NormCorpusInterface _instance) {
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
