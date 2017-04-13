pragma solidity ^0.4.8;

import "./Valid.sol";
import "./VotingInterface.sol";
import "./AbstractNormCorpus.sol";

contract Legislator is Valid {

    VotingInterface public voting ;

    function Legislator(VotingInterface _voting) {
      voting = _voting;
    }

    // Set a new NormCorpus contract
    function setNormCorpus(AbstractNormCorpus _normCorpus) isCallerValid isValid public {
        if (address(normCorpus) != 0x0) normCorpus.remove(_normCorpus);
        // Set the _normCorpus as the new instance of NormCorpus
        normCorpus = _normCorpus;
        // Set the address of the new norm corpus in isNorm mapping
        normCorpus.insert(_normCorpus);
    }

    // Set a new Voting contract
    function setVoting(VotingInterface _voting) isCallerValid isValid external {
        normCorpus.insert(_voting);
        //if (address(voting) != 0x0) normCorpus.remove(voting);
        // Set the new instance of voting
        voting = _voting;
    }

    function getVoting() constant public returns (VotingInterface) {
        return voting;
    }

    function proposeNorm(ProposalInterface _proposalInterface) isCallerValid isValid external {
        voting.propose(_proposalInterface);
    }

    function enactNorm(ProposalInterface _proposalInterface) external {
        if (!voting.isPassed(_proposalInterface)) throw;
        normCorpus.insert(_proposalInterface.getNorm());
    }
}
