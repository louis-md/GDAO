pragma solidity ^0.4.8;

import "../../ProposalInterface.sol";

contract TimeConstraintProposal {
    address proposedNorm;
    uint deadline;

    function TimeConstraintProposal(address _norm, uint _unixDeadline){
      proposedNorm = _norm;
      deadline =  _unixDeadline;
    }

    function getNorm() constant returns (address){
      return proposedNorm;
    }
}
