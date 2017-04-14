pragma solidity ^0.4.8;


import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";
import "../../ValidOrOwned.sol";

contract NaiveMajorityVoting is VotingInterface,ValidOrOwned {
    uint voters = 3;
    mapping (address => uint) votes;

    function NaiveMajorityVoting(){
        owner = msg.sender;
    }

    function vote(ProposalInterface _proposalInterface) external {
        votes[_proposalInterface]++; //TODO: i=i+1

    }

    function propose(ProposalInterface _proposalInterface) external{
        votes[_proposalInterface]=0;
    }

    function isPassed(ProposalInterface _proposalInterface) external constant returns (bool) {
        return votes[_proposalInterface] > voters;
    }
}
