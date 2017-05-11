pragma solidity ^0.4.11;

import "../../Valid.sol";
import "../../LegislatorInterface.sol";
import "../../GDAO.sol";

/// @notice "substitute the legislator by a simple majority vote of party members";
contract SubstituteLegislator is Valid{

    LegislatorInterface newLegislator;
    LegislatorInterface oldLegislator;

    function SubstituteLegislator(LegislatorInterface _old, LegislatorInterface _new, GDAO _proxy) Valid(_proxy){
        newLegislator = _new;
        oldLegislator = _old;
    }

    function execute() isValid external {
        NormCorpusInterface normCorpus= normCorpusProxy.getInstance();
        normCorpus.insert(newLegislator);
        normCorpus.remove(oldLegislator);
        //newLegislator.setVoting(oldLegislator.getVoting);
        suicide(newLegislator);
    }
}
