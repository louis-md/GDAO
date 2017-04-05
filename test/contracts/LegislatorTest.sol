pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/LawCorpus.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/laws/AutocraticVoting.sol";

contract LegislatorTest{
    Legislator public legislator;
    LawCorpus public registry;

    function beforeEach(){
      registry = new LawCorpus();
      legislator= new Legislator();
      legislator.setRegistry(registry);

    }


    function testWhenLegislatorRegistered_ThenProposalPossible(){
        var voting = new AutocraticVoting();
        legislator.setVoting(voting);
        //proposeLaw();
      //  Assert.isTrue(isInRegister(voting), "Setting valdid Voting fails");
    }

    /** helpers **/
    function isInRegister(address addr) constant returns (bool){
       return registry.contains(addr);
    }


}
