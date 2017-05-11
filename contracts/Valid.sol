pragma solidity ^0.4.11;

import "./GDAO.sol";

contract Valid {
    GDAO public normCorpusProxy;

    event NotValid(address);
    event CallerNotValid(address);

    function Valid(GDAO _proxy) {
      normCorpusProxy = _proxy;
    }

    modifier isValid {
        NormCorpusInterface normCorpus = normCorpusProxy.getInstance();
        if (address(normCorpus) != 0x0 && normCorpus.contains(address(this))) {
            _;
        }
        else NotValid(address(this));
    }

    modifier isCallerValid {
        NormCorpusInterface normCorpus = normCorpusProxy.getInstance();
        if (address(normCorpus) != 0x0 && normCorpus.contains(msg.sender)) {
            _;
        }
        else CallerNotValid(msg.sender);
    }
}
