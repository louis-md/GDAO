pragma solidity ^0.4.8;

import "./Valid.sol";

contract ValidOrOwned is Valid {
    address public owner;


    /**
     * Will be called automatically by all inheriting contracts.
     */
    function ValidOrOwned(){
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

    modifier onlyOwner(){
        if (owner != msg.sender) return;
        _;
    }

    function getOwner() external returns (address) {
        return owner;
    }

     function setOwner(address _newOwner) external returns (address) {
        owner = _newOwner;
    }

    function burnOwner() onlyOwner {

        owner = 0x00000000000000000000000000000000DeaDBeef; //thawing phase is over
    }
}
