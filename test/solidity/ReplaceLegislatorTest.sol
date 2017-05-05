pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/GDAO.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/SubstituteLegislator.sol";
import "../../contracts/example/norms/AutocraticVoting.sol";
import "../../contracts/example/proposals/DummyProposal.sol";
import "../../contracts/example/corpuses/IterableNormCorpus.sol";

contract ReplaceLegislatorTest{
    Legislator legislator;
    SubstituteLegislator norm;
    NormCorpus normCorpus;
    LegislatorInterface newLegislator;
    GDAO proxy;

    function beforeEach(){
      legislator = Legislator(DeployedAddresses.Legislator());
      normCorpus = NormCorpus(DeployedAddresses.NormCorpus());
      proxy = GDAO(DeployedAddresses.GDAO());
      newLegislator = new Legislator(proxy, legislator.getVoting());
      norm = new SubstituteLegislator(legislator, newLegislator, proxy);
      normCorpus.burnOwner();
      Legislator(legislator).burnOwner();
    }

    function testWhenSubstituteNormCorpusIsEnacted_ThenNewCorpus(){
      var proposal = new DummyProposal(norm);
      legislator.proposeNorm(proposal);
      AutocraticVoting(legislator.getVoting()).vote(proposal);
      bool result = legislator.enactNorm(proposal);
      Assert.isTrue(result, "Must be enacted, voted for");
      Assert.isTrue(normCorpus.contains(norm), "New norm must be in corpus");
      Assert.isFalse(normCorpus.contains(newLegislator), "newLegislator can't be installed");
      norm.execute();
      Assert.isTrue(normCorpus.contains(newLegislator), "newLegislator is now installed");
      Assert.isFalse(normCorpus.contains(legislator), "Old norm must be gone");
    }
}
