pragma solidity ^0.4.11.0;

import "./NormCorpusInterface.sol";
import "./NormCorpus.sol";
import "./GDAO.sol";
import "./Valid.sol";
import "./VotingInterface.sol";

contract LegislatorInterface {

  function setVoting(VotingInterface _voting) external;
  function getVoting() constant public returns (VotingInterface);
  function proposeNorm(ProposalInterface _proposalInterface) external;
  function enactNorm(ProposalInterface _proposalInterface) external returns (bool);
  event NormEnacted(address indexed norm);

}
