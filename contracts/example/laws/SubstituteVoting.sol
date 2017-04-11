pragma solidity ^0.4.8;

import "../../Law.sol";
import "../../VotingInterface.sol";
import "../../Legislator.sol";

contract SubstituteVoting is Law {

    VotingInterface newVoting;
    Legislator legislator;

    function SubstituteVoting(Legislator _legislator, VotingInterface _newvoting) {
        description = "substitute the court by a simple majority vote of party members";
        newVoting = _newvoting;
        legislator = _legislator;
    }

    function execute() isValid external {
        legislator.setVoting(newVoting);
        lawCorpus.remove(this);
        suicide(legislator);
    }
}
