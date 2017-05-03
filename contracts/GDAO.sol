pragma solidity ^0.4.8;

import "./NormCorpusInterface.sol";
import "./Owned.sol";

/*
** This is GDAO's main contract and only fixed point.
** It's linked to the NormCorpus since the deployment of the contract.
*/


contract GDAO is Owned{
    NormCorpusInterface instance;


    function GDAO(NormCorpusInterface _instance) {
        owner = msg.sender;
        instance = _instance;
    }

    function setInstance(NormCorpusInterface _instance)  {
        if (msg.sender != owner) throw;
        instance = _instance;
    }

    function getInstance() public constant returns (NormCorpusInterface) {
        return instance;
    }
}
