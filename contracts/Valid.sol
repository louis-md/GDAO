pragma solidity ^0.4.8;

import "./NormCorpusProxy.sol";

contract Valid {
    NormCorpusProxy public normCorpusProxy = NormCorpusProxy(0x00d76d2853321976999cb0998b6cbb5915085dd8);

    event NotValid(address);
    event CallerNotValid(address);

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
