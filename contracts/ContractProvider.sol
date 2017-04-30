pragma solidity ^0.4.6;

// Interface for getting contracts from GDAO
contract ContractProvider {
    function contracts(bytes32 name) returns (address addr);
}