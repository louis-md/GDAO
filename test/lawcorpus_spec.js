let LawCorpus = artifacts.require("./LawCorpus.sol");

contract('LawCorpus', (accounts) => {
  describe('When user insert a contract into the registry', () => {
    it("should increment numberOfLaws", () => {
      return LawCorpus.deployed().then((instance) => {
        instance.numberOfLaws.call()
          .then((r) => {
            assert.equal(r.toNumber(), 0, "numberOfLaws should equal to 0");
          })
          .then(() => {
            instance.insert.sendTransaction('0x3b4a55dd0926b8048266f17ed507907f1a2c1988')
              .then((tx) => {
                console.log(`Insert transaction ID: ${tx}`);
                instance.numberOfLaws.call()
                  .then((r) => {
                    assert.equal(r.toNumber(), 1, "numberOfLaws should equal to 1");
                  })
              })
              .catch((err) => console.log(`Insert failed: ${err}`))
          })
      });
    })
  });
});
