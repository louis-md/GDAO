pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/LawCorpus.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/laws/AutocraticVoting.sol";

contract LegislatorTest {

    Legislator public legislator;
    LawCorpus public lawCorpus;

    function beforeEach() {
      lawCorpus = new LawCorpus();
      legislator= new Legislator();
      legislator.setLawCorpus(lawCorpus);
    }

    function testWhenLegislatorRegistered_ThenProposalPossible() {
      var voting = new AutocraticVoting();
      legislator.setVoting(voting);
      // proposeLaw();
      // Assert.isTrue(isInRegister(voting), "Setting valdid Voting fails");
    }

    /** helpers **/
    function isInLawCorpus(address addr) constant returns (bool) {
       return lawCorpus.contains(addr);
    }
}
