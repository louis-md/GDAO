pragma solidity ^0.4.11;

import "./NormCorpusInterface.sol";
import "./NormCorpus.sol";
import "./GDAO.sol";
import "./ValidOrOwned.sol";
import "./VotingInterface.sol";
import "./LegislatorInterface.sol";

contract Legislator is ValidOrOwned, LegislatorInterface {

    VotingInterface public voting;

    // Derived() Based()
    function Legislator(GDAO _proxy, VotingInterface _voting) Valid(_proxy) {
      voting = _voting;
    }


    // Set a new Voting contract
    function setVoting(VotingInterface _voting) isCallerValid isValid external {
        NormCorpusInterface normCorpus = normCorpusProxy.getInstance();
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
        NormCorpusInterface normCorpus = normCorpusProxy.getInstance();
        address norm = _proposalInterface.getNorm();
        normCorpus.insert(norm);
        NormEnacted(norm);
        return true;
    }

}
