pragma solidity ^0.4.8;

import "./LawCorpus.sol";

contract Valid {
    LawCorpus public lawCorpus;
    address public owner; // for a thawing phase

    event NotValid(address);
    event CallerNotValid(address);
    event Msg(string mes);

    function Valid() {
        owner = msg.sender;
    }

    modifier isValid {
        if (address(lawCorpus) != 0x0 && lawCorpus.contains(address(this))) {
            _;
        }
        else if (owner != 0x00000000000000000000000000000000deadbeef && msg.sender == owner) {
            _;
        }
        else NotValid(address(this));
    }

    modifier isCallerValid {
        if (address(lawCorpus) != 0x0 && lawCorpus.contains(msg.sender)) {
            _;
        }
        else if (owner != 0x00000000000000000000000000000000deadbeef && msg.sender == owner) {
            _;
        }
        else CallerNotValid(msg.sender);
    }

    modifier onlyOwner {
        if (owner !=msg.sender) throw;
        _;
    }


    function getOwner() external returns (address) {
        return owner;
    }

    function burnOwner() isCallerValid {
        owner = 0x00000000000000000000000000000000deadbeef; //thawing phase is over
    }
}
