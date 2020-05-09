const SocialMoney = artifacts.require("SocialMoney");
const SocialMoneyFactory = artifacts.require("SocialMoneyFactory");
// const web3 = require("web3");

module.exports = function(deployer, network, accounts) {
  const _name = "socialmoney";
  const _symbol = "SOM";
  const _decimals = 18;

  // const rate = 10000;
  // const wallet = accounts[0];
  return deployer.then(() => {
    return deployer.deploy(SocialMoney, _name, _symbol, _decimals);
  }).then(() => {
    return deployer.deploy(
      SocialMoneyFactory,
      SocialMoney.address
    );
  })
};
