pragma solidity ^0.4.8;

contract AbstractNormCorpus {

    function insert(address _contract);

    function remove(address _contract);

    function contains(address _contract) public constant returns (bool);
}
