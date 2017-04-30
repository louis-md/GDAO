pragma solidity ^0.4.8;

import "./GDAOEnabled.sol";
import "./VotingInterface.sol";
import "./AbstractNormCorpus.sol";

contract Legislator is GDAOEnabled {

    VotingInterface public voting ;

    function Legislator(VotingInterface _voting) {
      voting = _voting;
    }

    // Set a new NormCorpus contract
    function setNormCorpus(AbstractNormCorpus _normCorpus) public {
        AbstractNormCorpus normCorpus = GDAO;
        if (address(normCorpus) != 0x0) normCorpus.deleteNorm(_normCorpus);
        // Set the _normCorpus as the new instance of NormCorpus
        normCorpus = _normCorpus;
        // Set the address of the new norm corpus in isNorm mapping
        normCorpus.insertProposal(_normCorpus);
    }

    // Set a new Voting contract
    function setVoting(VotingInterface _voting) external {
        AbstractNormCorpus normCorpus = GDAO;
        normCorpus.insertProposal(_voting);
        if (address(voting) != 0x0) normCorpus.deleteNorm(voting);
        // Set the new instance of voting
        voting = _voting;
    }

    function proposeNorm(ProposalInterface _proposalInterface) external {
        voting.propose(_proposalInterface);
    }

    function enactNorm(ProposalInterface _proposalInterface) external returns (bool){
        if (!voting.isPassed(_proposalInterface)) return false;
        AbstractNormCorpus normCorpus = GDAO;
        normCorpus.insertProposal(_proposalInterface.getNorm());
        return true;
    }
}
