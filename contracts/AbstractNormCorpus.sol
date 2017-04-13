import "./ValidOrOwned.sol";

contract AbstractNormCorpus is ValidOrOwned{
    function AbstractNormCorpus(){
      normCorpus = this;
    }

    function insert(address _contract);

    function remove(address _contract);

    function contains(address _contract) external constant returns(bool);
}
