pragma solidity ^0.4.8;

import "../../Valid.sol";
import "../../LegislatorInterface.sol";
import "../../GDAO.sol";

/// @notice "substitute the court by a simple majority vote of party members";
contract SubstituteNormCorpus is Valid{

    NormCorpusInterface public newNormCorpus;
    LegislatorInterface legislator;

    function SubstituteNormCorpus(LegislatorInterface _legislator, NormCorpusInterface _new, GDAO _proxy) Valid(_proxy){

        newNormCorpus = _new;
        legislator = _legislator;
    }

    function execute() isValid external {
        normCorpusProxy.setInstance(newNormCorpus);
        suicide(legislator);
    }
}
