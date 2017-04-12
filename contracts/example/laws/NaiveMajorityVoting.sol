pragma solidity ^0.4.8;


import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";


contract NaiveMajorityVoting is VotingInterface {
    uint voters = 3;
    mapping (uint => uint) votes;

    function DictatorVoting(){
        owner = msg.sender;
    }

    function vote(uint _proposalNumber) external {
        votes[_proposalNumber] ++;

    }

    function propose(uint _proposalNumber, uint _deadline) external {
        votes[_proposalNumber]=0;
    }

    function isPassed(uint _proposalNumber) external constant returns (bool) {
        return votes[_proposalNumber] > voters;
    }
}
