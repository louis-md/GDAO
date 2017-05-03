pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/NormCorpusProxy.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/AutocraticVoting.sol";

contract NormCorpusTest {

    NormCorpus public registry;

    function beforeEach() {
      var normCorpus = NormCorpus(DeployedAddresses.NormCorpus());
      var proxy = NormCorpusProxy(DeployedAddresses.NormCorpusProxy());
      registry = new NormCorpus();

    }

    //Inserting must be possible
    function testThawedInsert() {
      registry.insert(this);
      Assert.isTrue(isInRegister(this), "Insertion of this failed for owner");
    }

    //This is a low level test to check if burning owner works
    function testWhenRegistryOwnerBurned_ThenInsertNotPossible() {
        registry.burnOwner();
        registry.insert(this);
        Assert.isFalse(isInRegister(this), "Insertion of this cant work after burning owner");
    }

    //Inserting must be possible
    function testCallerValidInsert() {
      registry.insert(this);
      registry.burnOwner();
      Assert.isTrue(isInRegister(this), "Insertion of this failed for owner");
    }


    /** helpers **/
    function isInRegister(address addr) constant returns (bool) {
       return registry.contains(addr);
    }
}
