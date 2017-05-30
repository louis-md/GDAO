pragma solidity ^0.4.11;

import "./Owned.sol";

contract Members is Owned {
    mapping(address => bool) public members;

    function Members() {
      insertMember(owner);
    }

    modifier isCallerValidOrOwner {
        if (containsMember(msg.sender)) {
            _;
        } else {
          CallerNotValid(msg.sender);
        }
    }

    event CallerNotValid(address);

    function insertMember(address _memberAddress) isCallerValidOrOwner {
        members[_memberAddress] = true;
    }

    function removeMember(address _memberAddress) isCallerValidOrOwner {
        delete members[_memberAddress];
    }

    function containsMember(address _memberAddress) public constant returns (bool) {
        return members[_memberAddress];
    }
}
