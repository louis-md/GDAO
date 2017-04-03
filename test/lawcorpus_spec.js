let LawCorpus = artifacts.require("./LawCorpus.sol");
let instance = {};
let contractAddress = '0x3b4a55dd0926b8048266f17ed507907f1a2c1988';

contract('LawCorpus', (accounts) => {
  // runs before all tests in this block
  before(() => {
    // Put the contract instance in a variable
    LawCorpus.deployed().then((res) => {
      instance = res;
    });
  });

  it("should insert a contract into the registry", () => {
    return instance.numberOfLaws.call()
      .then((r) => {
        assert.equal(r.toNumber(), 0, "numberOfLaws should equal to 0");
      })
      .then(() => {
        instance.insert.sendTransaction(contractAddress)
          .then((tx) => {
            console.log(`Insert transaction ID: ${tx}`);
            instance.isLegit.call(contractAddress)
              .then((bool) => assert.ok(bool, 'Contract address should be truthy in isLegit registry'));
            instance.numberOfLaws.call()
              .then((r) => {
                assert.equal(r.toNumber(), 1, "numberOfLaws should equal to 1");
              })
          })
          .catch((err) => console.log(`Insert failed: ${err}`))
      })
  });

  it('should contain the contract address', () => {
    return instance.contains.call(contractAddress)
      .then((bool) => assert.ok(bool, 'should contain the inserted contract'));
  });

  it("should remove the inserted contract from the registry", () => {
    return instance.numberOfLaws.call()
      .then((r) => {
        assert.equal(r.toNumber(), 1, "numberOfLaws should equal to 1");
      })
      .then(() => {
        instance.remove.sendTransaction(contractAddress)
          .then((tx) => {
            console.log(`Remove transaction ID: ${tx}`);
            instance.isLegit.call(contractAddress)
              .then((bool) => assert.ok(!bool, 'Contract address should be falsy in isLegit registry'));
            instance.numberOfLaws.call()
              .then((r) => {
                assert.equal(r.toNumber(), 0, "numberOfLaws should equal to 0");
              })
          })
          .catch((err) => console.log(`Remove failed: ${err}`))
      })
  });
});
