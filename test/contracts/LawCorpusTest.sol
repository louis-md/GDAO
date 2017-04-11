pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/LawCorpus.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/laws/AutocraticVoting.sol";

contract LawCorpusTest{
    Legislator public legislator;
    LawCorpus public registry;

    function beforeEach(){
      registry = new LawCorpus();
      legislator= new Legislator();
    }

    function testThawedInsert(){
      registry.insert(legislator);
      Assert.isTrue(isInRegister(legislator), "Insertion of Legislator failed for owner");
    }

    //This is a low level test to check if 'valid' caller isValid works
    function testWhenRegistryOwnerBurned_ThenInsertNotPossible(){
        registry = new LawCorpus();
        //legislator.burnOwner();
        registry.burnOwner();
        registry.insert(legislator);
        Assert.isFalse(isInRegister(legislator), "Insertion of Legislator failed after burning owner");
    }

    /** helpers **/
    function isInRegister(address addr) constant returns (bool){
       return registry.contains(addr);
    }

}
