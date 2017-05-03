let AutocraticVoting = artifacts.require("AutocraticVoting");
let Legislator = artifacts.require("Legislator");
let NormCorpus = artifacts.require("NormCorpus");
let GDAO = artifacts.require("GDAO");
let Valid = artifacts.require("Valid");

module.exports = function (deployer) {
  deployer.deploy(NormCorpus)
    .then(() => console.log(`\n\nNormCorpus deployed at: ${NormCorpus.address}`))
    .then(() => deployer.deploy(GDAO, NormCorpus.address))
    .then(() => console.log(`GDAO deployed at: ${GDAO.address}`))
    .then(() => deployer.deploy(AutocraticVoting))
    .then(() => console.log(`AutocraticVoting deployed at: ${AutocraticVoting.address}`))
    .then(() => deployer.deploy(Legislator, GDAO.address, AutocraticVoting.address))
    .then(() => console.log(`Legislator deployed at: ${NormCorpus.at(NormCorpus.address).owner.call()}`))
    .then(() => NormCorpus.at(NormCorpus.address).insert(Legislator.address))
    .then(() => console.log(`Legislator ${Legislator.address} inserted into NormCorpus ${NormCorpus.address}`))
};
