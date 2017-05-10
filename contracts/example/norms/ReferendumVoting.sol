pragma solidity ^0.4.8;

import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";
import "../../ValidOrOwned.sol";
import "../../GDAO.sol";


/*
** This is a first implementation of a referendum vote.
** The "init" bool allows to make sure we can't vote for non existing proposals (needs to be done in other contracts too).
** For now we have 3 different choices : vote yes, vote no or vote null. 
*/


contract ReferendumVoting is VotingInterface, ValidOrOwned {

	struct PropInfo {
	uint totalVotes;
	uint yesVotes;
	uint noVotes;
	uint nullVotes;
	bool init;
	}

	PropInfo Proposal;
    mapping (address => PropInfo) ballot;


/*
** Constructor function is empty, maybe it could init the proposal.
*/

    function ReferendumVoting(GDAO _proxy) Valid(_proxy) {
			uint a = 1; 
	}

	function propose(ProposalInterface proposal) external {
			ballot[proposal].init = true;
    }
	
	// Next function is needed to compile :(
	function isPassed(ProposalInterface _proposalInterface) external constant returns (bool) {
			return true;
	}

    function voteYes(ProposalInterface proposal) external {
        if (ballot[proposal].init == true) {
			ballot[proposal].totalVotes++;
			ballot[proposal].yesVotes++;
		}
    }

    function voteNo(ProposalInterface proposal) external {
        if (ballot[proposal].init == true) {
			ballot[proposal].totalVotes++;
			ballot[proposal].noVotes++;
		}
    }

    function voteNull(ProposalInterface proposal) external {
        if (ballot[proposal].init == true) {
			ballot[proposal].totalVotes++;
			ballot[proposal].nullVotes++;
		}
    }
	function getWinningProposal(ProposalInterface proposal) external returns (bytes4) {
		if (ballot[proposal].yesVotes > ballot[proposal].noVotes && ballot[proposal].yesVotes > ballot[proposal].nullVotes)
			return "yes";
		else if (ballot[proposal].noVotes > ballot[proposal].yesVotes && ballot[proposal].noVotes > ballot[proposal].nullVotes)
			return "no";
		else if (ballot[proposal].nullVotes > ballot[proposal].yesVotes && ballot[proposal].nullVotes > ballot[proposal].noVotes)
			return "null";
		else
			return "tie";
		}

	function getTotalVotes(ProposalInterface proposal) external returns (uint){
		return (ballot[proposal].totalVotes);
	}

	function getYesVotes(ProposalInterface proposal) external returns (uint){
		return (ballot[proposal].yesVotes);
	}

	function getNoVotes(ProposalInterface proposal) external returns (uint){
		return (ballot[proposal].noVotes);
	}

	function getNullVotes(ProposalInterface proposal) external returns (uint){
		return (ballot[proposal].nullVotes);
	}
}

