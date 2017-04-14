var AbstractNormCorpus = artifacts.require("./AbstractNormCorpus.sol");
var AutocraticVoting = artifacts.require("../../AutocraticVoting.sol");
var Legislator = artifacts.require("./Legislator.sol");
var NormCorpus = artifacts.require("./NormCorpus.sol");
var NormCorpusProxy = artifacts.require("./NormCorpusProxy.sol");
var Proposal = artifacts.require("./ProposalInterface.sol");
var Voting = artifacts.require("./VotingInterface.sol");
var Valid = artifacts.require("./Valid.sol");


module.exports = function (deployer) {
  deployer.deploy(Valid);
  /*
   deployer.deploy(NormCorpus);
   deployer.deploy(AutocraticVoting).then(() => {
   deployer.deploy(Legislator, AutocraticVoting.address);
   });
   */

  // deployer.deploy(SubstituteVoting);
};

