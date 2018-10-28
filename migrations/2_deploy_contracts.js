const Asset = artifacts.require('./Asset.sol');
const Registry = artifacts.require('./Registry.sol');

module.exports = function(deployer) {
  Promise.all([
    deployer.deploy(Asset, 'TEST', 'Test Asset'),
    deployer.deploy(Registry)
  ]);
};
