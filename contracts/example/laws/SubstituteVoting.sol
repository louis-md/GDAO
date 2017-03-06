pragma solidity ^0.4.8;

import "../../Law.sol";
import "../../Voting.sol";
import "../../Legislator.sol";

contract SubstituteVoting is Law{

    Voting newVoting;
    Legislator legislator;

    function SubstituteVoting(Legislator _legislator, Voting _newvoting){
        description = "substitute the court by a simple majority vote of party members";
        newVoting = _newvoting;
        legislator = _legislator;
    }

    function execute() legit external{
        legislator.setVoting(newVoting);
        legalRegistry.remove(this);
        suicide(legislator);
    }

}
