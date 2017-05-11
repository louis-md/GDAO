pragma solidity ^0.4.11;

import "../../Valid.sol";
import "../../LegislatorInterface.sol";
import "../../GDAO.sol";

/// @notice "substitute the court by a simple majority vote of party members";
contract SubstituteNormCorpus is Valid{

    NormCorpusInterface public newNormCorpus;


    function SubstituteNormCorpus(NormCorpusInterface _new, GDAO _proxy) Valid(_proxy){
        newNormCorpus = _new;
    }

    function execute() isValid external {
        normCorpusProxy.setInstance(newNormCorpus);
        suicide(newNormCorpus);
    }
}
