pragma solidity ^0.4.8;

import "../../Proposal.sol";
import "../../Voting.sol";


contract AutocraticVoting is Voting{

    mapping (address => bool) passed;
    function AutocraticVoting(){
        owner = msg.sender;
    }

    function vote(address _proposal) external{
        if (msg.sender != owner) throw;
        passed[_proposal] = true;
    }

    function propose(Proposal _proposal) external{
        passed[_proposal]=false;
    }

    function isPassed(Proposal _proposal) external constant returns (bool){
        return passed[_proposal];
    }

}
