pragma solidity ^0.4.8;

contract valid {
    LawCorpus public legalRegistry;
    address public owner; // for a thawing phase

    function Legitime(){
        owner = msg.sender;
    }

    modifier legit {
        if (address(legalRegistry) != 0x0 && legalRegistry.contains(address(this))){
            _;
        }
        else if (owner !=  0xdeadbeef && msg.sender == owner) {

            _;
        }
        else NotLegit(address(this));
    }
    event NotLegit(address);

    modifier callerLegit {

        if (address(legalRegistry) != 0x0 && legalRegistry.contains(msg.sender)){
            _;
        }
        else if (owner !=  0xdeadbeef && msg.sender == owner) {
            _;
        }
        else CallerNotLegit(msg.sender);
    }

    modifier onlyOwner {
        if (owner !=msg.sender) throw;
        _;
    }

    event CallerNotLegit(address);
    event Msg(string mes);

    function getOwner() external returns(address){
        return owner;
    }

    function burnOwner() callerLegit{
        owner = 0xdeadbeef; //thawing phase is over
    }

}



contract LawCorpus is valid{

    mapping(address => bool) public isLegit;
    uint public numberOfLaws;


    function LawCorpus (){
        legalRegistry = this;
        owner= msg.sender;
    }

    function insert(address _contract) callerLegit {
        isLegit[_contract]=true;
        numberOfLaws++;
    }


    function remove(address _contract) callerLegit {
        isLegit[_contract]=false;
        numberOfLaws--;
    }

    function contains(address _contract) external constant returns(bool){
        return isLegit[_contract];
    }


}
