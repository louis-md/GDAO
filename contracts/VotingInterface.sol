pragma solidity ^0.4.8;


import "./Law.sol";
import "./ProposalInterface.sol";

contract VotingInterface is Valid {

    function propose(ProposalInterface _proposalInterface) external;
    function isPassed(ProposalInterface _proposalInterface) external constant returns (bool);
}
