let GDAO = artifacts.require("GDAO");
let IterableAddressToBoolMap = artifacts.require("IterableAddressToBoolMap");
let IterableNormCorpus = artifacts.require("IterableNormCorpus");
let SubstituteNormCorpus = artifacts.require("SubstituteNormCorpus");
let Membership = artifacts.require("Membership")
let MajorityVotingWithMembership = artifacts.require("MajorityVotingWithMembership");

module.exports = function (deployer) {
  let initialMembers = [web3.eth.coinbase];
  deployer.deploy(IterableAddressToBoolMap)
    .then(() => console.log(`\n\IterableAddressToBoolMap deployed at: ${IterableAddressToBoolMap.address}`))
    .then(() => deployer.link(IterableAddressToBoolMap, IterableNormCorpus))
    .then(() => console.log("IterableAddressToBoolMap linked to IterableNormCorpus"))
    .then(() => deployer.deploy(Membership, initialMembers ))
    .then(() => console.log(`GDAO deployed at: ${GDAO.address}`))
    .then(() => deployer.deploy(MajorityVotingWithMembership, GDAO.address, Membership.address ));
    //.then(() => deployer.deploy(IterableNormCorpus))
    //.then(() => console.log(`IterableNormCorpus deployed at: ${IterableNormCorpus.address}`))
}
