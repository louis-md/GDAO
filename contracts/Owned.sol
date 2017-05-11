pragma solidity ^0.4.11;

contract Owned {
    address public owner;


    /**
     * Will be called automatically by all inheriting contracts.
     */
    function Owned(){
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        if (owner != msg.sender) return;
        _;
    }

    function getOwner() external returns (address) {
        return owner;
    }

     function setOwner(address _newOwner) external onlyOwner returns (address) {
        owner = _newOwner;
    }

    function burnOwner() external onlyOwner {

        owner = 0x00000000000000000000000000000000DeaDBeef; //thawing phase is over
    }
}
