pragma solidity ^0.4.8;

import "./Valid.sol";
import "./VotingInterface.sol";

contract Legislator is Valid {

    VotingInterface public voting ;

    function Legislator() {
    }

    // Set a new LawCorpus contract
    function setLawCorpus(LawCorpus _lawCorpus) isCallerValid isValid public {
        if (address(lawCorpus) != 0x0) lawCorpus.remove(_lawCorpus);
        // Set the _lawCorpus as the new instance of LawCorpus
        lawCorpus = _lawCorpus;
        // Set the address of the new law corpus in isLaw mapping
        lawCorpus.insert(_lawCorpus);
    }

    // Set a new Voting contract
    function setVoting(VotingInterface _voting) isCallerValid isValid external {
        lawCorpus.insert(_voting);
        //if (address(voting) != 0x0) lawCorpus.remove(voting);
        // Set the new instance of voting
        voting = _voting;
    }

    function getVoting() constant public returns (VotingInterface) {
        return voting;
    }

    function proposeLaw(ProposalInterface _proposalInterface) isCallerValid isValid external {
        voting.propose(_proposalInterface);
    }

    function enactLaw(ProposalInterface _proposalInterface) external {
        if (!voting.isPassed(_proposalInterface)) throw;
        lawCorpus.insert(_proposalInterface.getLaw());
    }
}