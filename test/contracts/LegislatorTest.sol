pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/AutocraticVoting.sol";
import "../../contracts/example/proposals/TimeConstraintProposal.sol";

contract LegislatorTest{
    Legislator public legislator;
    NormCorpus public registry;

    function beforeEach(){
      registry = new NormCorpus();
      var voting = new AutocraticVoting();
      legislator= new Legislator(voting);

      legislator.setNormCorpus(registry);

    }


    function testWhenLegislatorRegistered_ThenProposalPossible(){

      legislator.setVoting(voting);
      //var Norm =
      //var Proposal =
      //legislator.proposeNorm();

      //  Assert.isTrue(isInRegister(voting), "Setting valdid Voting fails");
    }

    /** helpers **/
    function isInRegister(address addr) constant returns (bool){
       return registry.contains(addr);
    }


}
