pragma solidity ^0.4.8;

import "./NormCorpusProxy.sol";

contract Valid {
    NormCorpusProxy public normCorpusProxy;

    event NotValid(address);
    event CallerNotValid(address);
    event Msg(string mes);

    function Valid(NormCorpusProxy _normCorpusProxy) {
        normCorpusProxy = _normCorpusProxy;
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
