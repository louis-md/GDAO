pragma solidity ^0.4.8;

import "./Valid.sol";

contract LawCorpus is Valid{

    mapping(address => bool) public isLegit;
    uint public numberOfLaws;


    function LawCorpus (){
        legalRegistry = this;
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
