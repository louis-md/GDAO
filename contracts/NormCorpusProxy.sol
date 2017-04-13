contract NormCorpusProxy is ValidOrOwned{
    AbstractNormCorpus instance;


    function NormCorpusProxy(AbstractNormCorpus _instance){

        instance = _instance;
    }

    function setInstance(AbstractNormCorpus _instance) isCallerValidOrOwner{
        instance = _instance;
    }

    function getInstance() public constant returns(AbstractNormCorpus) {
        return instance;
    }
}
