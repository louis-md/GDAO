pragma solidity ^0.4.8;

import "./NormCorpus.sol";

contract Valid {
    NormCorpus public normCorpus;
    address public owner; // for a thawing phase

    event NotValid(address);
    event CallerNotValid(address);
    event Msg(string mes);

    function Valid() {
        owner = msg.sender;
    }

    modifier isValid {
        if (address(normCorpus) != 0x0 && normCorpus.contains(address(this))) {
            _;
        }
        else NotValid(address(this));
    }

    modifier isCallerValid {
        if (address(normCorpus) != 0x0 && normCorpus.contains(msg.sender)) {
            _;
        }
        else CallerNotValid(msg.sender);
    }

}
