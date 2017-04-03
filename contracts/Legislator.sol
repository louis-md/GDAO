pragma solidity ^0.4.8;

import "./Valid.sol";
import "./Voting.sol";

contract Legislator is Valid {

    Voting public voting ;

    function Legislator() {
        owner = msg.sender;
        //setRegistry(LawCorpus(corpus));
    }

    function setRegistry(LawCorpus _registry) callerLegit legit public {
        if (address(legalRegistry) != 0x0) legalRegistry.remove(_registry);
        legalRegistry = _registry;
        legalRegistry.insert(_registry);
    }

    function setVoting(Voting _voting) callerLegit legit external {
        legalRegistry.insert(_voting);
        //if (address(voting) != 0x0) legalRegistry.remove(voting);
        voting = _voting;
    }

    function getVoting() constant public returns (Voting){
        return voting;
    }

    function proposeLaw(Proposal _proposal) callerLegit legit external {
        voting.propose(_proposal);
    }

    function enactLaw(Proposal _proposal)  external {
        if (!voting.isPassed(_proposal)) throw;
        legalRegistry.insert(_proposal.getLaw());
    }
}
