pragma solidity ^0.4.8;

import "./LawCorpus.sol";

contract Valid {
    LawCorpus public legalRegistry;
    address public owner; // for a thawing phase

    event NotLegit(address);
    event CallerNotLegit(address);
    event Msg(string mes);

    function Valid() {
        owner = msg.sender;
    }

    modifier legit {
        if (address(legalRegistry) != 0x0 && legalRegistry.contains(address(this))){
            _;
        }
        else if (owner !=  0x00000000000000000000000000000000deadbeef && msg.sender == owner) {

            _;
        }
        else NotLegit(address(this));
    }

    modifier callerLegit {
        if (address(legalRegistry) != 0x0 && legalRegistry.contains(msg.sender)){
            _;
        }
        else if (owner !=  0x00000000000000000000000000000000deadbeef && msg.sender == owner) {
            _;
        }
        else CallerNotLegit(msg.sender);
    }

    modifier onlyOwner {
        if (owner !=msg.sender) throw;
        _;
    }


    function getOwner() external constant returns(address) {
        return owner;
    }

    function burnOwner() callerLegit {
        owner = 0x00000000000000000000000000000000deadbeef; //thawing phase is over
    }
}