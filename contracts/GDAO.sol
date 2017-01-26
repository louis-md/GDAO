pragma solidity ^0.4.4;

contract Legitimate {
    Legislation public legalRegistry;
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



contract Legislation is Legitimate{

    mapping(address => bool) public isLegit;
    uint public numberOfLaws;


    function Legislation (){
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

contract Legislator is Legitimate{


    Voting public voting ;


    function Legislator (){
        owner= msg.sender;
        setRegistry(new Legislation());
    }

    function setRegistry(Legislation _registry) callerLegit legit public{
        if (address(legalRegistry) != 0x0) legalRegistry.remove(_registry);
        legalRegistry = _registry;
        legalRegistry.insert(_registry);

    }

    function setVoting(Voting _voting) callerLegit legit external{
        legalRegistry.insert(_voting);
        //if (address(voting) != 0x0) legalRegistry.remove(voting);
        voting = _voting;
    }
    function getVoting() constant public returns (Voting){
        return voting;
    }

    function proposeLaw(Proposal _proposal) callerLegit legit external{

        voting.propose(_proposal);
    }

    function enactLaw(Proposal _proposal)  external{
        if (!voting.isPassed(_proposal)) throw;
        legalRegistry.insert(_proposal.getLaw());

    }

}

contract Voting is Legitimate {

    function propose(Proposal _proposal) external;
    function isPassed(Proposal _proposal) external constant returns (bool);
}

contract AutocraticVoting is Voting{

    mapping (address => bool) passed;
    function AutocraticVoting(){
        owner = msg.sender;
    }

    function vote(address _proposal) external{
        if (msg.sender != owner) throw;
        passed[_proposal] = true;
    }

    function propose(Proposal _proposal) external{
        passed[_proposal]=false;
    }

    function isPassed(Proposal _proposal) external constant returns (bool){
        return passed[_proposal];
    }

}
contract NaiveMajorityVoting is Voting{
    uint voters = 3;
    mapping (uint => uint) votes;

    function DictatorVoting(){
        owner = msg.sender;
    }

    function vote(uint _proposalNumber) external{
        votes[_proposalNumber] ++;

    }

    function propose(uint _proposalNumber, uint _deadline) external{
        votes[_proposalNumber]=0;
    }

    function isPassed(uint _proposalNumber) external constant returns (bool){
        return votes[_proposalNumber] > voters;
    }

}


contract Law is Legitimate{
  string public description;
}

contract Proposal{
    function getLaw() constant returns (Law){

    }
}

contract SubstituteVoting is Law{

    Voting newVoting;
    Legislator legislator;

    function SubstituteVoting(Legislator _legislator, Voting _newvoting){
        description = "substitute the court by a simple majority vote of party members";
        newVoting = _newvoting;
        legislator = _legislator;
    }

    function execute() legit external{
        legislator.setVoting(newVoting);
        legalRegistry.remove(this);
        suicide(legislator);
    }

}
