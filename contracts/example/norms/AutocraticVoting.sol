pragma solidity ^0.4.8;

import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";
import "../../ValidOrOwned.sol";


contract AutocraticVoting is VotingInterface, ValidOrOwned {

    mapping (address => bool) passed;

    function AutocraticVoting(GDAO _proxy) Valid(_proxy){

    }

    function vote(address _proposal) external {
        //TODO: if (msg.sender != owner) throw;
        passed[_proposal] = true;
    }

    function propose(ProposalInterface _proposal) external {
        passed[_proposal]=false;
    }

    function isPassed(ProposalInterface _proposal) external constant returns (bool) {
        return passed[_proposal];
    }
}
