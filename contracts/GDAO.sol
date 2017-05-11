pragma solidity ^0.4.11;

import "./NormCorpusInterface.sol";

/*
** This is GDAO's main contract and only fixed point.
** It's linked to the NormCorpus since the deployment of the contract.
*/
contract GDAO {

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
