pragma solidity ^0.4.8;

import "./AbstractNormCorpus.sol";
import "./ContractProvider.sol";

// Base class for contracts that are used in the GDAO system.
contract GDAOEnabled {
    AbstractNormCorpus public GDAO;
    event NotValid(address);
    event CallerNotValid(address);

    function setGDAOAddress(address gdaoAddr) returns (bool) {
        if (msg.sender != address(GDAO)) throw;
        GDAO = AbstractNormCorpus(gdaoAddr);
        return true;
    }

    modifier canCall(bytes32 name) {
      address inst = ContractProvider(GDAO).contracts(name);
      if (inst != 0x0) {
         _;
      }
    }

    modifier canBeCalledBy(bytes32 name) {
      address inst = ContractProvider(GDAO).contracts(name);
      if (inst == msg.sender) {
         _;
      }
    }
}
