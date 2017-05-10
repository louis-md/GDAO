pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/GDAO.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/SubstituteNormCorpus.sol";
import "../../contracts/example/norms/Autocracy.sol";
import "../../contracts/example/proposals/DummyProposal.sol";
import "../../contracts/example/corpuses/IterableNormCorpus.sol";

contract ReplaceNormCorpusTest{
    LegislatorInterface legislator;
    SubstituteNormCorpus norm;
    NormCorpus normCorpus;
    IterableNormCorpus newCorpus;
    GDAO proxy;

    function beforeEach(){
      legislator = LegislatorInterface(DeployedAddresses.Legislator());
      normCorpus = NormCorpus(DeployedAddresses.NormCorpus());
      proxy = GDAO(DeployedAddresses.GDAO());
      newCorpus = new IterableNormCorpus();
      norm = new SubstituteNormCorpus(newCorpus, proxy);
      normCorpus.burnOwner();
      Legislator(legislator).burnOwner();
    }

    function testWhenSubstituteNormCorpusIsEnacted_ThenNewCorpus(){
      var proposal = new DummyProposal(norm);
      legislator.proposeNorm(proposal);
      Autocracy oldNorm = Autocracy(legislator.getVoting());
      oldNorm.vote(proposal);
      bool result = legislator.enactNorm(proposal);
      Assert.isTrue(result, "Must be enacted, voted for");
      Assert.isTrue(normCorpus.contains(norm), "New norm must be in corpus");
      Assert.isFalse(address(proxy.getInstance()) == address(newCorpus), "IterableNormCorpus can't be installed");
      norm.execute();
      Assert.isTrue(address(proxy.getInstance()) == address(newCorpus), "IterableNormCorpus is now installed");
      //Assert.isFalse(normCorpus.contains(oldNorm), "Old norm must be gone");*/
    }
}
