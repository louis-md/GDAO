pragma solidity ^0.4.8;

import "./LawCorpus.sol";

contract Valid {
    LawCorpus public legalRegistry;
    address public owner; // for a thawing phase

    function Legitime(){
        owner = msg.sender;
    }

    modifier legit {
        if (address(legalRegistry) != 0x0 && legalRegistry.contains(address(this))){
            _;
        }
        else if (owner !=  0xdeadbeef && msg.sender == owner) {

            _;
        }
        else NotLegit(address(this));
    }
    event NotLegit(address);

    modifier callerLegit {

        if (address(legalRegistry) != 0x0 && legalRegistry.contains(msg.sender)){
            _;
        }
        else if (owner !=  0xdeadbeef && msg.sender == owner) {
            _;
        }
        else CallerNotLegit(msg.sender);
    }

    modifier onlyOwner {
        if (owner !=msg.sender) throw;
        _;
    }

    event CallerNotLegit(address);
    event Msg(string mes);

    function getOwner() external returns(address){
        return owner;
    }

    function burnOwner() callerLegit{
        owner = 0xdeadbeef; //thawing phase is over
    }
}