let Valid = artifacts.require("./Valid.sol");
let instance = {};

contract('Valid', (accounts) => {
  // runs before all tests in this block
  before(() => {
    //console.log('List all accounts');
    //console.log(accounts);
    web3.eth.default = accounts[0];
    //console.log('web3.eth.default', web3.eth.default);

    // Put the contract instance in a variable
    return Valid.deployed().then((res) => {
      instance = res;
    });
  });

  it("should burn owner", async () => {
    let ownerAddr = await instance.getOwner.call();
    assert.equal(ownerAddr, accounts[0], 'ownerAddr should equal accounts[0]');
    await instance.burnOwner();
    let burnedOwnerAddr = await instance.getOwner.call();
    assert.equal(burnedOwnerAddr, '0x00000000000000000000000000000000deadbeef', 'burnedOwnerAddr should equal 0xdeadbeef');
  });
});
