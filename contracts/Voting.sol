pragma solidity ^0.4.8;


import "./Law.sol";
import "./Proposal.sol";

contract Voting is Valid {

    function propose(Proposal _proposal) external;
    function isPassed(Proposal _proposal) external constant returns (bool);
}
