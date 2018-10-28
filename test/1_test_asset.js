const Asset = artifacts.require('Asset.sol');
const { expectThrow } = require('./helpers/expectThrow');

contract('Asset', (accounts) => {
    it('should deploy a Asset', async () => {
        const asset = await Asset.new('DRAW', 'Philanthropy Draw', { from: accounts[0] });
        if (asset.address === undefined) throw new Error('deployment of asset failed');
    });

    it('should mint an Asset', async () => {
        const asset = await Asset.new('DRAW', 'Philanthropy Draw', { from: accounts[0] });
        await asset.mint(100, accounts[1], { from: accounts[0] });
        const balance = await asset.balanceOf(accounts[1]);
        const totalSupply = await asset.totalSupply();
        if (balance.toString() !== '100') throw new Error('minting did not distribute asset');
        if (totalSupply.toString() !== '100') throw new Error('minting did not update total supply');
        if (asset.address === undefined) throw new Error('deployment of asset failed');
    });

    it('should lock an Asset', async () => {
        const asset = await Asset.new('DRAW', 'Philanthropy Draw', { from: accounts[0] });
        await asset.mint(100, accounts[1], { from: accounts[0] });
        const balance = await asset.balanceOf(accounts[1]);
        const totalSupply = await asset.totalSupply();
        if (balance.toString() !== '100') throw new Error('minting did not distribute asset');
        if (totalSupply.toString() !== '100') throw new Error('minting did not update total supply');
        if (asset.address === undefined) throw new Error('deployment of asset failed');
        await asset.lock({ from: accounts[0] });
        await expectThrow( asset.mint(100, accounts[1], { from: accounts[0] }) );
    });

    it('should allow metadata to be set', async () => {
        const asset = await Asset.new('DRAW', 'Philanthropy Draw', {from: accounts[0]});
        await asset.setMetadata(
            'description',
            'Made from the golden spine ripped from the back of the god Midasel and tied with a bowstring made from a single silver hair stolen from the goddess Ariana in her slumber. Copurnius the brother of the two, spurned by his siblings for being less beautiful than they, wished to see an end to the greed painted upon humanity\'s creation by them. \n' +
            '\n' +
            'He forged this bow for one with a will for the weak. Arrowheads made from the copper in his eyes, he was the one not blinded by greed, but by quite literally blinded by his charity. This bow deemed "Philanthropy Draw" was most famously used by the held by the figure known as Robin Hood. \n' +
            '\n' +
            'Many others though, throughout history have been the wielders of this bow though, providing to all.'
        );
        await asset.setMetadata('rarity', 'Epic');
        await asset.setMetadata('version', 'Origin');
        const metadataResult = await asset.metadata('description');
        const name = await asset.name();
        const symbol = await asset.symbol();
        const rarity = await asset.metadata('rarity');
        const version = await asset.metadata('version');
        if (rarity !== 'Epic') throw new Error('metadata rarity not set or received');
        if (name !== 'Philanthropy Draw') throw new Error('name not set or received');
        if (symbol !== 'DRAW') throw new Error('symbol not set or received');
        if (version !== 'Origin') throw new Error('version not set or received');
        await expectThrow( asset.setMetadata('rarity', 'Epic') );
    });
});
