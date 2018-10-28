const Asset = artifacts.require('Asset.sol');
const Registry = artifacts.require('Registry.sol');

contract('Registry', (accounts) => {
    it ('should deploy a Registry', async () => {
        const registry = await Registry.new();
        if (registry.address === undefined) throw new Error('deployment of registry failed');
    });

    it ('should create an Asset in the registry', async () => {
        const registry = await Registry.new();
        const asset = await registry.create('CHKN', 'Chicken', 'chicken', {from: accounts[0]});
        const assets = await registry.getAssets();
        if (assets[0] !== '0x636869636b656e00000000000000000000000000000000000000000000000000') throw new Error('deployment of asset failed');
        if (registry.address === undefined) throw new Error('deployment of registry failed');
    });
});
