pragma solidity ^0.4.8;

import "../../ProposalInterface.sol";
import "../../VotingInterface.sol";
import "../../ValidOrOwned.sol";


contract Autocracy is VotingInterface, ValidOrOwned {

    mapping (address => bool) adoptedProposal;

    function Autocracy(GDAO _proxy) Valid(_proxy){

    }

    function vote(address _proposal) external {
        //TODO: if (msg.sender != owner) throw;
        adoptedProposal[_proposal] = true;
    }

    function propose(ProposalInterface _proposal) external {
        adoptedProposal[_proposal]=false;
    }

    function isPassed(ProposalInterface _proposal) external constant returns (bool) {
        return adoptedProposal[_proposal];
    }
}
