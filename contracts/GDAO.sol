pragma solidity ^0.4.8;

import "./NormCorpusInterface.sol";

contract GDAO{
    NormCorpusInterface instance;


    function GDAO(NormCorpusInterface _instance) {
        instance = _instance;
    }

    function setInstance(NormCorpusInterface _instance)  {
        if (!instance.contains(msg.sender)) throw;
        instance = _instance;
    }

    function getInstance() public constant returns (NormCorpusInterface) {
        return instance;
    }
}
