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
    // return deployer.deploy(SocialMoney, _name, _symbol, _decimals);
    return deployer.deploy(
      SocialMoneyFactory,
      '0x0d8c05d08bB619307AA8b611579ab357a4A08517'
    );
  }).then(() => {
    /* return deployer.deploy(
      SocialMoneyFactory,
      SocialMoney.address
    ); */
  })
};
