pragma solidity ^0.4.4;
import "GDAO.sol";

contract AaLegitimationTest{
    Legislator public legislator;
    Legislation public registry;


    function TestThawedInsert(){

        legislator= new Legislator();
        registry = new Legislation();

        registry.insert(legislator); // the legislator is a legit contract
        if(assertInserted()) log0(1);
    }

    function WhenRegistryOwnerBurned_ThenInsertNotPossible(){
        legislator= new Legislator();
        registry = new Legislation();
        //legislator.burnOwner();
        registry.burnOwner();
        registry.insert(legislator);
        if(!assertInserted()) log0(2);
    }

    function WhenLegislatorRegistered_ThenProposalPossible(){
        legislator= new Legislator();
        registry = new Legislation();
        registry.insert(legislator);
        registry.burnOwner();
        var voting = new DictatorVoting();
        legislator.setVoting(voting);
       // if(!assertInserted()) log0(3);
    }

    function assertInserted() constant returns (bool){
       return registry.contains(legislator);
    }
}
