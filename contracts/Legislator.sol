pragma solidity ^0.4.8;

import "./AbstractNormCorpus.sol";
import "./NormCorpus.sol";
import "./NormCorpusProxy.sol";
import "./Valid.sol";
import "./VotingInterface.sol";

contract Legislator is Valid {

    VotingInterface public voting;

    // Derived() Based()
    function Legislator(NormCorpusProxy _proxy, VotingInterface _voting) Valid(_proxy) {
      voting = _voting;
    }

    // Set a new NormCorpus contract
    function setNormCorpus(AbstractNormCorpus _normCorpus) isCallerValid isValid public {
        AbstractNormCorpus normCorpus = normCorpusProxy.getInstance();
        if (address(normCorpus) != 0x0) normCorpus.remove(_normCorpus);
        // Set the _normCorpus as the new instance of NormCorpus
        //normCorpus = AbstractNormCorpus(NormCorpus(_normCorpus));
        normCorpus = _normCorpus;
        // Set the address of the new norm corpus in isNorm mapping
        normCorpus.insert(_normCorpus);
    }

    // Set a new Voting contract
    function setVoting(VotingInterface _voting) isCallerValid isValid external {
        AbstractNormCorpus normCorpus = normCorpusProxy.getInstance();
        normCorpus.insert(_voting);
        if (address(voting) != 0x0) normCorpus.remove(voting);
        // Set the new instance of voting
        voting = _voting;
    }

    function getVoting() constant public returns (VotingInterface) {
        return voting;
    }

    function proposeNorm(ProposalInterface _proposalInterface) isCallerValid isValid external {
        voting.propose(_proposalInterface);
    }

    function enactNorm(ProposalInterface _proposalInterface) external returns (bool){
        if (!voting.isPassed(_proposalInterface)) return false;
        AbstractNormCorpus normCorpus = normCorpusProxy.getInstance();
        address norm = _proposalInterface.getNorm();
        normCorpus.insert(norm);
        NormEnacted(norm);
        return true;
    }
    event NormEnacted(address indexed norm);
}
