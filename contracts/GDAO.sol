pragma solidity ^0.4.8;

import "./AbstractNormCorpus.sol";
import "./GDAOEnabled.sol";

contract GDAO is AbstractNormCorpus {

    struct Norm {
        bytes16 IPFSMultiHash;
        address norm;
        bool isAdopted;
        uint yes; // total 'yes' votes
        uint no; // total 'no' votes
        bool voteIsOpen; // if the votes are 'opened'
        mapping(address => bool) voters; // people in this list have already voted
    }

    mapping(bytes32 => Norm) public norms;
    uint public numberOfNorms;

    function insertProposal(bytes32 _name, address _contract) returns (bool) {
      GDAOEnabled ge = GDAOEnabled(_contract);
      if (!ge.setGDAOAddress(address(this))) {
        return false;
      }
      norms[_name] = Norm('ipfs_hash', _contract, false, 0, 0, false);
      numberOfNorms = numberOfNorms + 1;
    }

    function deleteNorm(bytes32 _name) {
        delete norms[_name];
        numberOfNorms = numberOfNorms - 1;
    }

    // setVotingSystem
    // one is set by default

    // Anyone can request to open the voting session ?
    function openVote(bytes32 _name) {
       //GDAOEnabled ge = GDAOEnabled("votingSystem");
        //if (!ge.setGDAOAddress(address(this))) {
          //return false;
        //}
        // voting phase
        // votingSystem.voteProposal(bytes32 proposalId, bool yes, address voter)
        // pass the proposal as adopted or rejected
    }
}
