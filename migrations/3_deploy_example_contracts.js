let IterableAddressToBoolMap = artifacts.require("IterableAddressToBoolMap");
let IterableNormCorpus = artifacts.require("IterableNormCorpus");
let SubstituteNormCorpus = artifacts.require("SubstituteNormCorpus");

module.exports = function (deployer) {
  deployer.deploy(IterableAddressToBoolMap)
    .then(() => console.log(`\n\IterableAddressToBoolMap deployed at: ${IterableAddressToBoolMap.address}`))
    .then(() => deployer.link(IterableAddressToBoolMap, IterableNormCorpus))
    .then(() => console.log("IterableAddressToBoolMap linked to IterableNormCorpus"));
    //.then(() => deployer.deploy(IterableNormCorpus))
    //.then(() => console.log(`IterableNormCorpus deployed at: ${IterableNormCorpus.address}`))
}
