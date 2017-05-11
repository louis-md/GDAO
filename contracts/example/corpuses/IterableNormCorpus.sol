pragma solidity ^0.4.11;

import "../../NormCorpusInterface.sol";
import "./IterableAddressToBoolMap.sol";
import "../../Owned.sol";

contract IterableNormCorpus is Owned, NormCorpusInterface {
    IterableAddressToBoolMap.itmap public isNorm;
    uint public numberOfNorms;

    function NormCorpus(){
    }

    modifier isCallerValidOrOwner {

        if (contains(msg.sender)) {
            _;
        }
        else if (owner == msg.sender) {
            _;
        }
        else CallerNotValid(msg.sender);
    }
    event CallerNotValid(address);

    function insert(address _contract)  isCallerValidOrOwner {
        IterableAddressToBoolMap.insert(isNorm,_contract,true);
        numberOfNorms = numberOfNorms + 1;
    }

    function remove(address _contract)  isCallerValidOrOwner {
        IterableAddressToBoolMap.remove(isNorm,_contract);
        numberOfNorms = numberOfNorms - 1;
    }

    function contains(address _contract) public constant returns(bool) {
        return IterableAddressToBoolMap.contains(isNorm,_contract);
    }


  function listNormsAsEvents() returns (bool s)
  {
    for (var i = IterableAddressToBoolMap.iterate_start(isNorm); IterableAddressToBoolMap.iterate_valid(isNorm, i); i = IterableAddressToBoolMap.iterate_next(isNorm, i))
    {
        var (key, value) = IterableAddressToBoolMap.iterate_get(isNorm, i);
        NormListed(key, value);
    }
  }
  event NormListed(address norm, bool isEnabled);
}
