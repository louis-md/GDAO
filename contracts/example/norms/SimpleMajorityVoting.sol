pragma solidity ^0.4.8;

import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";
import "../../ValidOrOwned.sol";
import "../../GDAO.sol";

contract SimpleMajorityVoting is VotingInterface, ValidOrOwned {
    uint voters = 0;
    mapping (address => uint) votes;

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
	
	function getVotersNumber() external returns (uint){
		return (voters);
	}

}
