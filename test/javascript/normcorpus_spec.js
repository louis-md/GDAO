let NormCorpusAbstraction = artifacts.require("NormCorpus");
let NormCorpus = null;
let contractAddress = '0xdeadbeef';

let beforeWrapper = function(accounts) {
  before(async () => {
    //console.log('List all accounts');
    //console.log(accounts);
    //web3.eth.default = web3.eth.accounts[0];
    //console.log('web3.eth.default', web3.eth.default);

    // Put the contract NormCorpus in a variable
    NormCorpus = await NormCorpusAbstraction.deployed();
  });
};

contract('NormCorpus', (accounts) => {
  // runs before all tests in this block
  beforeWrapper(accounts);

  it("should insert a contract into the registry", async () => {
    // deploy 3 insert Legislator to NormCorpus
    let numNorms = await NormCorpus.numberOfNorms.call();
    assert.equal(numNorms.valueOf(), 1, "numberOfNorms should equal to 1");
    let txInsert = await NormCorpus.insert.sendTransaction(contractAddress);
    console.log(`Insert transaction ID: ${txInsert}`);
    let isNormBool = await NormCorpus.isNorm.call(contractAddress);
    assert.ok(isNormBool, 'Contract address should be truthy in isNorm registry');
    let numNorms2 = await NormCorpus.numberOfNorms.call();
    assert.equal(numNorms2.toNumber(), 2, "numberOfNorms should equal to 2");
  });
});


contract('NormCorpus 2', (accounts) => {
  // runs before all tests in this block
  beforeWrapper(accounts);

  it('should contain the contract address', async () => {
    await NormCorpus.insert.sendTransaction(contractAddress);
    let bool = await NormCorpus.contains.call(contractAddress);
    assert.ok(bool, 'should contain the inserted contract');
  });
});


contract('NormCorpus 3', (accounts) => {
  // runs before all tests in this block
  beforeWrapper(accounts);

  it("should remove the inserted contract from the registry", async () => {
    await NormCorpus.insert.sendTransaction(contractAddress);
    let numNorms = await NormCorpus.numberOfNorms.call();
    assert.equal(numNorms.toNumber(), 2, "numberOfNorms should equal to 2");
    let txInsert = await NormCorpus.remove.sendTransaction(contractAddress);
    console.log(`Remove transaction ID: ${txInsert}`);
    let bool = await NormCorpus.isNorm.call(contractAddress);
    assert.ok(!bool, 'Contract address should be falsy in isNorm registry');
    let numNorms2 = await NormCorpus.numberOfNorms.call();
    assert.equal(numNorms2.toNumber(), 1, "numberOfNorms should equal to 1");
  });
});
