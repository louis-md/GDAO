pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/AutocraticVoting.sol";
import "../../contracts/example/norms/NaiveMajorityVoting.sol";
import "../../contracts/example/norms/SubstituteVoting.sol";
import "../../contracts/example/proposals/DummyProposal.sol";

contract ReplaceVotingTest{
    Legislator public legislator;
    VotingInterface public voting;
    SubstituteVoting public norm;

    function beforeEach(){
      legislator = Legislator(DeployedAddresses.Legislator());
      voting = new NaiveMajorityVoting();
      norm = new SubstituteVoting(legislator, voting);
    }

    function testWhenSubstituteVotingIsEnacted_ThenNewVoting(){
      var proposal = new DummyProposal(norm);
      legislator.proposeNorm(proposal);
      legislator.enactNorm(proposal);
      //  Assert.isTrue(isInRegister(voting), "Setting valdid Voting fails");*/
    }


}
