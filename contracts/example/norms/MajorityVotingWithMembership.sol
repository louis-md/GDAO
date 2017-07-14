pragma solidity ^0.4.11;

import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";
import "../../ValidOrOwned.sol";
import "../../GDAO.sol";
import "./Membership.sol";

contract MajorityVotingWithMembership is VotingInterface,ValidOrOwned
{
    uint quorum = 3;
    mapping (address => uint) votes;
    Membership members;

    function MajorityVotingWithMembership(GDAO _proxy, Membership _members) Valid(_proxy){
        owner = msg.sender;
        members = _members;
    }

    function vote(ProposalInterface _proposalInterface) external {
        if (!members.contains(msg.sender)) throw;
        votes[_proposalInterface]++; //TODO: i=i+1
    }

    function propose(ProposalInterface _proposalInterface) external{
        votes[_proposalInterface]=0;
    }

    function isPassed(ProposalInterface _proposalInterface) external constant returns (bool) {
        return votes[_proposalInterface] > quorum; //TODO: replace with your fav voting rule
    }
}
