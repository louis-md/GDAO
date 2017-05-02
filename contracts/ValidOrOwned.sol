pragma solidity ^0.4.8;

import "./Valid.sol";
import "./Owned.sol";

contract ValidOrOwned is Valid, Owned {
    address public owner;


    /**
     * Will be called automatically by all inheriting contracts.
     */
    function ValidOrOwned() Owned(){
        owner = msg.sender;
    }

    modifier isValidOrOwner {
        AbstractNormCorpus normCorpus = normCorpusProxy.getInstance();
        if (address(normCorpus) != 0x0 && normCorpus.contains(address(this))) {
            _;
        }
        else if (owner ==msg.sender) {
            _;
        }
        else NotValid(address(this));
    }

    modifier isCallerValidOrOwner {
        AbstractNormCorpus normCorpus = normCorpusProxy.getInstance();
        if (address(normCorpus) != 0x0 && normCorpus.contains(msg.sender)) {
            _;
        }
        else if (owner == msg.sender) {
            _;
        }
        else CallerNotValid(msg.sender);
    }

}
