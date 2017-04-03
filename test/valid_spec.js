let Valid = artifacts.require("./Valid.sol");
let instance = {};

contract('Valid', (accounts) => {
  // runs before all tests in this block
  before(() => {
    // List all accounts
    console.log('List all accounts');
    console.log(accounts);

    // Put the contract instance in a variable
    Valid.deployed().then((res) => {
      instance = res;
    });
  });

  it("should burn owner", () => {
    return instance.getOwner.call()
      .then((ownerAddr) => {
        assert.equal(ownerAddr, accounts[0], 'ownerAddr should equal accounts[0]');
        instance.burnOwner()
          .then(() => {
            instance.getOwner.call()
              .then((burnedOwnerAddr) => {
                assert.equal(burnedOwnerAddr, '0x00000000000000000000000000000000deadbeef', 'burnedOwnerAddr should equal 0xdeadbeef');
              });
          });
      });
  });
});
