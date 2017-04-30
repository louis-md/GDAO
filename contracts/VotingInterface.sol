pragma solidity ^0.4.8;

import "./ProposalInterface.sol";
import "./GDAOEnabled.sol";

contract VotingInterface {

    function propose(ProposalInterface _proposalInterface) external;
    function isPassed(ProposalInterface _proposalInterface) external constant returns (bool);
}
