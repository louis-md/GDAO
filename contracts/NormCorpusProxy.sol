pragma solidity ^0.4.8;

import "./AbstractNormCorpus.sol";

contract NormCorpusProxy {
    AbstractNormCorpus instance;
    address public owner;

    function NormCorpusProxy(AbstractNormCorpus _instance) {
        owner = msg.sender;
        instance = _instance;
    }

    function setInstance(AbstractNormCorpus _instance) {
        if (msg.sender != owner) throw;
        instance = _instance;
    }

    function getInstance() public constant returns (AbstractNormCorpus) {
        return instance;
    }
}
