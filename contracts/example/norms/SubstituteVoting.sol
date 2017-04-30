pragma solidity ^0.4.8;

import "../../GDAOEnabled.sol";
import "../../VotingInterface.sol";
import "../../Legislator.sol";

/// @notice "substitute the court by a simple majority vote of party members";
contract SubstituteVoting is GDAOEnabled {

    VotingInterface newVoting;
    Legislator legislator;

    function SubstituteVoting(Legislator _legislator, VotingInterface _newvoting) {
        newVoting = _newvoting;
        legislator = _legislator;
    }

    function execute() external {
        legislator.setVoting(newVoting);
        AbstractNormCorpus normCorpus = GDAO;
        normCorpus.deleteNorm(this);
        suicide(legislator);
    }
}
