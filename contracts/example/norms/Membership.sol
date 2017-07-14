pragma solidity ^0.4.11;

contract Membership //isValidOrOwned
{

    struct Members {
      address [] list;
      mapping (address => bool) lookup;
    }

    Members members;

    function Membership(address [] _initialMembers){
        setMembers(_initialMembers);
    }

    function setMembers(address [] _initialMembers) internal {
        members.list = _initialMembers;
        for (uint32 i=0; i < _initialMembers.length; i++){
          members.lookup[_initialMembers[i]]=true;
        }
    }

    function removeMember(address _member) returns (bool success) //isCallerValid
    {
        delete members.lookup[_member];
        for(uint32 i= 0; i < members.list.length; i++)        {
            if (members.list[i]== _member) delete members.list[i];
        }
        return true;
    }

    function addMember(address _member) returns (bool success) //isCallerValid
    {
        members.lookup[_member]=true;
        members.list.push(_member);
        return true;
    }

    function contains(address member) constant returns (bool isMember){

    }
}
