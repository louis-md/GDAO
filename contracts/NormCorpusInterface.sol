pragma solidity ^0.4.11;

contract NormCorpusInterface {

    function insert(bytes32 _name, address _contract);

    function remove(bytes32 _name);

    function contains(bytes32 _name) public constant returns (bool);

}
