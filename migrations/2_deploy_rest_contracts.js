let Autocracy = artifacts.require("Autocracy");
let Legislator = artifacts.require("Legislator");
let NormCorpus = artifacts.require("NormCorpus");
let GDAO = artifacts.require("GDAO");
let Valid = artifacts.require("Valid");

module.exports = function (deployer) {
  deployer.deploy(NormCorpus)
    .then(() => console.log(`\n\nNormCorpus deployed at: ${NormCorpus.address}`))
    .then(() => deployer.deploy(GDAO, NormCorpus.address))
    .then(() => console.log(`GDAO deployed at: ${GDAO.address}`))
    .then(() => deployer.deploy(Autocracy))
    .then(() => console.log(`Autocracy deployed at: ${Autocracy.address}`))
    .then(() => deployer.deploy(Legislator, GDAO.address, Autocracy.address))
    .then(() => console.log(`Legislator deployed at: ${NormCorpus.at(NormCorpus.address).owner.call()}`))
    .then(() => NormCorpus.at(NormCorpus.address).insert(Legislator.address))
    .then(() => console.log(`Legislator ${Legislator.address} inserted into NormCorpus ${NormCorpus.address}`))
};
