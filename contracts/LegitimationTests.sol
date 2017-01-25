pragma solidity ^0.4.4;
import "GDAO.sol";

contract AaLegitimationTest{
    Legislator public legislator;
    Legislation public registry;


    function TestThawedInsert(){

        legislator= new Legislator();
        registry = new Legislation();

        registry.insert(legislator); // the legislator is a legit contract
        if(assertInserted(legislator)) log0(1);
    }

    //This is a low level test to check if 'legit' caller legit works
    function WhenRegistryOwnerBurned_ThenInsertNotPossible(){
        legislator= new Legislator();
        registry = new Legislation();
        //legislator.burnOwner();
        registry.burnOwner();
        registry.insert(legislator);
        if(!assertInserted(legislator)) log0(2);
    }

    // this goes a bit higher in the abstraction and checks if a legit
    function WhenLegislatorRegistered_ThenProposalPossible(){
        legislator= new Legislator();

        var voting = new AutocraticVoting();
        legislator.setVoting(voting);
        if(!assertInserted(voting)) log0(3);
    }

    function assertInserted(address addr) constant returns (bool){
       return registry.contains(addr);
    }
}
