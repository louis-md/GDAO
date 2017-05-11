pragma solidity ^0.4.11;

import "./ProposalInterface.sol";
import "./Valid.sol";

contract VotingInterface is Valid {

    function propose(ProposalInterface _proposalInterface) external;
    function isPassed(ProposalInterface _proposalInterface) external constant returns (bool);
}
