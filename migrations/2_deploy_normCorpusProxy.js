let NormCorpus = artifacts.require("./NormCorpus.sol");
let NormCorpusProxy = artifacts.require("./NormCorpusProxy.sol");

/**
 * Deployment Process
1. We deploy a NormCorpusProxy. This is the only fixpoint in the system
2. We change the address of NormCorpusProxy in Valid. This is constant for the whole organisation
3. As a owner I can now NormCorpusProxy.setInstance(new NormCorpus())
4. A first Voting system gets instantiated.
5. As a owner I can now insert the Legislator in the Normcorpus


 truffle migrate --to 2
 truffle migrate -f 3
*/

module.exports = function (deployer) {
  deployer.deploy(NormCorpus)
    .then(() => deployer.deploy(NormCorpusProxy, NormCorpus.address, {overwrite: false}))
};
