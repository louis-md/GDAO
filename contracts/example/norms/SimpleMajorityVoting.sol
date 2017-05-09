pragma solidity ^0.4.8;

import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";
import "../../ValidOrOwned.sol";
import "../../GDAO.sol";


/*
** This is a first implementation of a majority vote.
** The simple majority voting rule increments the voters count number for each vote.
** The proposal is considered to be passed if it has at least (voters / 2 + 1) votes.
*/


contract SimpleMajorityVoting is VotingInterface, ValidOrOwned {
	
	struct PropState {
	uint votes;
	bool init;
	}

	PropState Proposal;	
    uint voters = 0;
    mapping (address => PropState) votes;


// Constructor function is empty
    function SimpleMajorityVoting(GDAO _proxy) Valid(_proxy){
    }

    function vote(ProposalInterface _proposalInterface) external {
        if (votes[_proposalInterface].init == true)
		{	
			votes[_proposalInterface].votes++;
			voters++;
		}
    }

    function propose(ProposalInterface _proposalInterface) external{
			votes[_proposalInterface].init = true;
			votes[_proposalInterface].votes = 0; //Probably useless
    }

    function isPassed(ProposalInterface proposalToCheck) external constant returns (bool) {
        if (voters < 2) 
			throw;
		return (votes[proposalToCheck].votes > (voters / 2));
    }


// The two functions below are for informations purpose only.

	function getProposalVotes(ProposalInterface _proposalInterface) external returns (uint){
		return (votes[_proposalInterface].votes);
	}

	function getVotersNumber() external returns (uint){
		return (voters);
	}

	function getVotesRequiredToPass() external returns (uint){
		return (voters / 2 + 1);
	}
}
