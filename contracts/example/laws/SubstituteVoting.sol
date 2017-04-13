pragma solidity ^0.4.8;

import "../../Valid.sol";
import "../../VotingInterface.sol";
import "../../Legislator.sol";

/// @notice "substitute the court by a simple majority vote of party members";
contract SubstituteVoting is Valid{

    VotingInterface newVoting;
    Legislator legislator;

    function SubstituteVoting(Legislator _legislator, VotingInterface _newvoting) {

        newVoting = _newvoting;
        legislator = _legislator;
    }

    function execute() isValid external {
        legislator.setVoting(newVoting);
        normCorpus.remove(this);
        suicide(legislator);
    }
}
