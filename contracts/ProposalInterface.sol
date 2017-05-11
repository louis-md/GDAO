pragma solidity ^0.4.11;

contract ProposalInterface {
    function getNorm() public constant returns (address);

    /**
    * @dev get the current state of the proposal
    */
    function getState() public constant returns (ProposalState);

    enum ProposalState    {NOTVOTABLE, VOTABLE, ADOPTED, REJECTED}
}
