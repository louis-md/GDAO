pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/AutocraticVoting.sol";
import "../../contracts/example/norms/NaiveMajorityVoting.sol";
import "../../contracts/example/norms/SubstituteVoting.sol";
import "../../contracts/example/proposals/DummyProposal.sol";

contract LegislatorTest{
    Legislator public legislator;
    NormCorpus public registry;

    function beforeEach(){
      /*registry = new NormCorpus();
      var voting = new AutocraticVoting();
      legislator= new Legislator(voting);

      legislator.setNormCorpus(registry);*/

    }


    function testWhenLegislatorRegistered_ThenProposalPossible(){
      Legislator legislator = Legislator(DeployedAddresses.Legislator());
      VotingInterface voting = new NaiveMajorityVoting();
      var norm = new SubstituteVoting(legislator, voting);
      var proposal = new DummyProposal(norm);
      legislator.proposeNorm(proposal);
      legislator.enactNorm(proposal);
      //  Assert.isTrue(isInRegister(voting), "Setting valdid Voting fails");
    }

    /** helpers **/
    function isInRegister(address addr) constant returns (bool){
       return registry.contains(addr);
    }


}
