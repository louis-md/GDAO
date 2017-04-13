pragma solidity ^0.4.8;

import "./ValidOrOwned.sol";

contract AbstractNormCorpus is ValidOrOwned{
    
    function insert(address _contract);

    function remove(address _contract);

    function contains(address _contract) external constant returns(bool);
}
