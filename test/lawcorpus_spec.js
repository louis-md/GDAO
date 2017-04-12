let LawCorpus = artifacts.require("./LawCorpus.sol");
let instance = {};
let contractAddress = '0x3b4a55dd0926b8048266f17ed507907f1a2c1988';

let beforeWrapper = function(accounts) {
  before(async () => {
    //console.log('List all accounts');
    //console.log(accounts);
    //web3.eth.default = web3.eth.accounts[0];
    //console.log('web3.eth.default', web3.eth.default);

    // Put the contract instance in a variable
    let res = await LawCorpus.deployed();
    instance = res;
  });
};

contract('LawCorpus', (accounts) => {
  // runs before all tests in this block
  beforeWrapper(accounts);

  it("should insert a contract into the registry", async () => {
    let numLaws = await instance.numberOfLaws.call();
    assert.equal(numLaws.toNumber(), 0, "numberOfLaws should equal to 0");
    let txInsert = await instance.insert.sendTransaction(contractAddress);
    console.log(`Insert transaction ID: ${txInsert}`);
    let isLawBool = await instance.isLaw.call(contractAddress);
    assert.ok(isLawBool, 'Contract address should be truthy in isLaw registry');
    let numLaws2 = await instance.numberOfLaws.call();
    assert.equal(numLaws2.toNumber(), 1, "numberOfLaws should equal to 1");
  });
});


contract('LawCorpus 2', (accounts) => {
  // runs before all tests in this block
  beforeWrapper(accounts);

  it('should contain the contract address', async () => {
    await instance.insert.sendTransaction(contractAddress);
    let bool = await instance.contains.call(contractAddress);
    assert.ok(bool, 'should contain the inserted contract');
  });
});


contract('LawCorpus 3', (accounts) => {
  // runs before all tests in this block
  beforeWrapper(accounts);

  it("should remove the inserted contract from the registry", async () => {
    await instance.insert.sendTransaction(contractAddress);
    let numLaws = await instance.numberOfLaws.call();
    assert.equal(numLaws.toNumber(), 1, "numberOfLaws should equal to 1");
    let txInsert = await instance.remove.sendTransaction(contractAddress);
    console.log(`Remove transaction ID: ${txInsert}`);
    let bool = await instance.isLaw.call(contractAddress);
    assert.ok(!bool, 'Contract address should be falsy in isLegit registry');
    let numLaws2 = await instance.numberOfLaws.call();
    assert.equal(numLaws2.toNumber(), 0, "numberOfLaws should equal to 0");
  });
});
