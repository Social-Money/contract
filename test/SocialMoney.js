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
    // await SocialMoneyFactoryInstance.createToken('奥利给2', 'ALG2');
    const tokenAddress = await SocialMoneyFactoryInstance.getToken(a0);
    const tokenAddress0 = await SocialMoneyFactoryInstance.getTokenWithId(0);
    const tokenAddress1 = await SocialMoneyFactoryInstance.getTokenWithId(1);
    const tokenCount = await SocialMoneyFactoryInstance.tokenCount();
    console.log('tokenAddress0', tokenAddress0);
    console.log('tokenAddress1', tokenAddress1);
    console.log('tokenCount', tokenCount.toString());

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