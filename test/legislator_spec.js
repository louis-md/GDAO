let Legislator = artifacts.require("./Legislator.sol");
let instance = {};

contract('Legislator', (accounts) => {
  // runs before all tests in this block
  before(() => {
    // Put the contract instance in a variable
    return Legislator.deployed().then((res) => {
      instance = res;
    });
  });

  it.skip("should insert a contract into the registry", () => {

  });
});