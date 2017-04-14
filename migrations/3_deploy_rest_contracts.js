var Valid = artifacts.require("./Valid.sol");
var AbstractNormCorpus = artifacts.require("./AbstractNormCorpus.sol");
var NormCorpus = artifacts.require("./NormCorpus.sol");
var Legislator = artifacts.require("./Legislator.sol");
var Proposal = artifacts.require("./ProposalInterface.sol");
var Voting = artifacts.require("./VotingInterface.sol");
var AutocraticVoting = artifacts.require("../../AutocraticVoting.sol");

/**
1. We deploy a NormCorpusProxy. This is the only fixpoint in the system
2. We change the address of NormCorpusProxy in Valid. This is constant for the whole organisation
3. As a owner I can now NormCorpusProxy.setInstance(new NormCorpus())
4. A first Voting system gets instantiated.
5. As a owner I can now insert the Legislator in the Normcorpus
*/
module.exports = function (deployer) {

  deployer.deploy(AutocraticVoting).then(()=>{
     return deployer.deploy(Legislator, AutocraticVoting.address);
  }).then(() => {
      return NormCorpus.at(NormCorpus.address).insert(Legislator.address);
  }).then(() => console.log('Legislator inserted into NormCorpus') );

};
