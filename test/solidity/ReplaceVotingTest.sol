pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/NormCorpusProxy.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/AutocraticVoting.sol";
import "../../contracts/example/norms/NaiveMajorityVoting.sol";
import "../../contracts/example/norms/SubstituteVoting.sol";
import "../../contracts/example/proposals/DummyProposal.sol";

contract ReplaceVotingTest{
    Legislator legislator;
    SubstituteVoting norm;
    NormCorpus normCorpus;
    NaiveMajorityVoting newVoting;

    function beforeEach(){
      legislator = Legislator(DeployedAddresses.Legislator());
      normCorpus = NormCorpus(DeployedAddresses.NormCorpus());
      var proxy = NormCorpusProxy(DeployedAddresses.NormCorpusProxy());
      newVoting = new NaiveMajorityVoting(proxy);
      norm = new SubstituteVoting(legislator, newVoting, proxy);
    }

    function testWhenSubstituteVotingIsEnacted_ThenNewVoting(){
      var proposal = new DummyProposal(norm);
      legislator.proposeNorm(proposal);
      bool result = legislator.enactNorm(proposal);
      Assert.isFalse(result, "Cant be enacted, no vote has been casted");
      AutocraticVoting oldNorm = AutocraticVoting(legislator.getVoting());
      oldNorm.vote(proposal);
      result = legislator.enactNorm(proposal);
      Assert.isTrue(result, "Must be enacted, voted for");
      Assert.isTrue(normCorpus.contains(norm), "New norm must be in corpus");
      norm.execute();
      Assert.isFalse(normCorpus.contains(norm), "Norm had to remove itself");
      Assert.isTrue(normCorpus.contains(newVoting), "NaiveMajorityVoting is now a norm");
      Assert.isTrue(address(legislator.getVoting())== address(newVoting), "new Voting must have been installed");
      //Assert.isFalse(normCorpus.contains(oldNorm), "Old norm must be gone");*/
    }


}
