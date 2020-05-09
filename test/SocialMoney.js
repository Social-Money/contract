const SocialMoney = artifacts.require("SocialMoney");
const SocialMoneyFactory = artifacts.require("SocialMoneyFactory");
const Web3 = require("web3")
const fs = require('fs');
const path = require('path');
const token_abi = fs.readFileSync(path.join(__dirname, '../build/contracts/SocialMoney.json'));

contract("SocialMoney", async accounts => {
  it("should deploy a erc20 token:", async () => {
    const [ a0, ...rest] = accounts;
    // let SocialMoneyInstance = await SocialMoney.deployed();
    let SocialMoneyFactoryInstance = await SocialMoneyFactory.deployed();
    await SocialMoneyFactoryInstance.createToken('奥利给', 'ALG');
    const tokenAddress = await SocialMoneyFactoryInstance.getToken(a0);

    const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:7545'));
    web3.eth.defaultAccount = a0;
    const tokenInstance = new web3.eth.Contract(JSON.parse(token_abi).abi, tokenAddress);
    const totalSupply = await tokenInstance.methods.totalSupply().call();
    const owner = await tokenInstance.methods.owner().call();
    const name = await tokenInstance.methods.name().call();
    const symbol = await tokenInstance.methods.symbol().call();
    assert.equal(totalSupply, 21000);
    // assert.equal(owner, a0);
    assert.equal(name, '奥利给');
    assert.equal(symbol, 'ALG');
  });
});