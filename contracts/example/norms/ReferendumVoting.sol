pragma solidity ^0.4.8;

import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";
import "../../ValidOrOwned.sol";
import "../../GDAO.sol";


/*
** This is a first implementation of a referendum vote.
** TODO: Add accurate description
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


// Constructor function is empty

    function ReferendumVoting(GDAO _proxy) Valid(_proxy) {
    }
    
	function propose(ProposalInterface proposal) external {
			ballot[proposal].init = true;
    }

    function vote_yes(ProposalInterface proposal) external {
        if (ballot[proposal].init == true) {	
			ballot[proposal].totalVotes++;
			ballot[proposal].yesVotes++;
		}
    }

    function vote_no(ProposalInterface proposal) external {
        if (ballot[proposal].init == true) {	
			ballot[proposal].totalVotes++;
			ballot[proposal].noVotes++;
		}
    }

    function vote_null(ProposalInterface proposal) external {
        if (ballot[proposal].init == true) {	
			ballot[proposal].totalVotes++;
			ballot[proposal].nullVotes++;
		}
    }
	//	TODO: Function Ispassed
}


// The two functions below are for informations purpose only.

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
