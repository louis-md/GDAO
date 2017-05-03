pragma solidity ^0.4.8;

import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";
import "../../ValidOrOwned.sol";
import "../../GDAO.sol";


/*
** This is a first implementation of a majority vote.
** The simple majority voting rule increments the "voters" number for each vote.
** The proposal is considered to be passed if it has at least (voters / 2 + 1) votes.
*/


contract SimpleMajorityVoting is VotingInterface, ValidOrOwned {
    uint voters = 0;
    mapping (address => uint) votes;


// Constructor function is empty
    function SimpleMajorityVoting(GDAO _proxy) Valid(_proxy){
    }

    function vote(ProposalInterface _proposalInterface) external {
        votes[_proposalInterface]++;
		voters++;
    }

    function propose(ProposalInterface _proposalInterface) external{
		votes[_proposalInterface] = 0;
    }

    function isPassed(ProposalInterface proposalToCheck) external constant returns (bool) {
        if (voters < 2) 
			throw;
		return (votes[proposalToCheck] > (voters / 2));
    }


// The two functions below are for informations purpose only.

	function getVotersNumber() external returns (uint){
		return (voters);
	}

	function getVotesRequiredToPass() external returns (uint){
		return (voters / 2 + 1);
	}
}
