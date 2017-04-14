pragma solidity ^0.4.8;

import "./NormCorpusProxy.sol";

contract Valid {
    NormCorpusProxy public normCorpusProxy = NormCorpusProxy(0xdb8ec8f8f5ad1bf0fe99745959da10d9b06a3bd3);

    event NotValid(address);
    event CallerNotValid(address);
    event Msg(string mes);

    function Valid() {

    }

    modifier isValid {
        AbstractNormCorpus normCorpus = normCorpusProxy.getInstance();
        if (address(normCorpus) != 0x0 && normCorpus.contains(address(this))) {
            _;
        }
        else NotValid(address(this));
    }

    modifier isCallerValid {
        AbstractNormCorpus normCorpus = normCorpusProxy.getInstance();
        if (address(normCorpus) != 0x0 && normCorpus.contains(msg.sender)) {
            _;
        }
        else CallerNotValid(msg.sender);
    }
}
