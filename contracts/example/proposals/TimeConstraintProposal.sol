pragma solidity ^0.4.11;

import "../../ProposalInterface.sol";

contract TimeConstraintProposal is ProposalInterface{
    address proposedNorm;
    uint public deadline;


    function TimeConstraintProposal(address _norm, uint _unixDeadline){
      proposedNorm = _norm;
      deadline =  _unixDeadline;
    }

    function getNorm() constant returns (address){
      return proposedNorm;
    }

    function getState() public constant returns (ProposalState){
       if (now < deadline)
          return ProposalState.VOTABLE;
       //TODO: needs state voting
       return ProposalState.ADOPTED;
    }
}
