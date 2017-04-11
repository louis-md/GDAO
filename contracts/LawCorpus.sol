pragma solidity ^0.4.8;

import "./Valid.sol";

contract LawCorpus is Valid {

    mapping(address => bool) public isLaw;
    uint public numberOfLaws;

    function LawCorpus() {
        lawCorpus = this;
    }

    function insert(address _contract) isCallerValid {
        isLaw[_contract]=true;
        numberOfLaws++;
    }

    function remove(address _contract) isCallerValid {
        delete isLaw[_contract];
        numberOfLaws--;
    }

    function contains(address _contract) external constant returns(bool) {
        return isLaw[_contract];
    }
}