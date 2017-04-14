pragma solidity ^0.4.8;

import "../../ProposalInterface.sol";

contract DummyProposal is ProposalInterface{
    address proposedNorm;

    function DummyProposal(address _norm){
      proposedNorm = _norm;
    }

    function getNorm() constant returns (address){
      return proposedNorm;
    }

    function getState() public constant returns (ProposalState){
       return ProposalState.PASSED;
    }
}
