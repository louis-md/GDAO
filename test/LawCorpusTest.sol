pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/LawCorpus.sol";
import "../contracts/Legislator.sol";
import "../contracts/example/laws/AutocraticVoting.sol";

contract LawCorpusTest{
    Legislator public legislator;
    LawCorpus public registry;

    function LawCorpusTest(){

      registry = new LawCorpus();

    }

    function testThawedInsert(){

        legislator= new Legislator();
        registry.insert(legislator);
        Assert.isTrue(isInRegister(legislator), "Insertion of Legislator failed for owner");
    }


//This is a low level test to check if 'valid' caller legit works
function testWhenRegistryOwnerBurned_ThenInsertNotPossible(){
    legislator= new Legislator();
    registry = new LawCorpus();
    //legislator.burnOwner();
    registry.burnOwner();
    registry.insert(legislator);
    Assert.isFalse(isInRegister(legislator), "Insertion of Legislator failed after burning owner");
}

// this goes a bit higher in the abstraction and checks if a valid caller can call
function testWhenLegislatorRegistered_ThenProposalPossible(){
    legislator= new Legislator();

    var voting = new AutocraticVoting();
    legislator.setVoting(voting);
    Assert.isTrue(isInRegister(voting), "Setting valdid Voting fails");
}


    /** helpers **/
    function isInRegister(address addr) constant returns (bool){
       //return registry.contains(addr);
    }
}
