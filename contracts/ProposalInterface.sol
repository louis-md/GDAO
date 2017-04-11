pragma solidity ^0.4.8;

import "./Law.sol";

contract ProposalInterface {
    function getLaw() constant returns (Law);
    function isVotable() constant returns (bool);
}
