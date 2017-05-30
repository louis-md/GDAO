pragma solidity ^0.4.11;

import "./NormCorpusInterface.sol";
import "./GDAO.sol";
import "./Owned.sol";

contract NormCorpus is NormCorpusInterface, Owned {

    mapping(bytes32 => address) public isNorm;
    uint public numberOfNorms;


    function NormCorpus() {
      owner = msg.sender;
    }

    modifier isCallerValidOrOwner(bytes32 _name) {
        if (contains(_name)) {
            _;
        }
        else if (owner == msg.sender) {
            _;
        }
        else CallerNotValid(msg.sender);
    }

    event CallerNotValid(address);

    function insert(bytes32 _name, address _contract) isCallerValidOrOwner(_name) {
        isNorm[_name] = _contract;
        numberOfNorms = numberOfNorms + 1;
    }

    function remove(bytes32 _name) isCallerValidOrOwner(_name) {
        delete isNorm[_name];
        numberOfNorms = numberOfNorms - 1;
    }

    function contains(bytes32 _name) public constant returns (bool) {
        if (isNorm[_name] == 0x0) {
            return true;
        } else {
            return false;
        }
    }
}
