pragma solidity ^0.4.11;

contract NormCorpusInterface {

    function insert(address _contract);

    function remove(address _contract);

    function contains(address _contract) public constant returns (bool);

}
