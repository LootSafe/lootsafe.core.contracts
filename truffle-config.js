/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() {
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>')
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
    networks: {
        development: {
              host: "localhost",
              port: 8545,
              network_id: "*" // Match any network id
        },
        rinkeby: {
            host: "18.188.26.7", // Connect to geth on the specified
            port: 8545,
            from: "0x60e8103256851cb8ab81a80714373b4d5ceec629", // default address to use for any transaction Truffle makes during migrations
            network_id: "*", // Match any network id
            gas: 6400000 // Gas limit used for deploys
        },
        kovan: {
            host: "127.0.0.1",
            port: 8545,
            network_id: 42,
            gas: 4700000,
            from: '0xa5c55ef045e6715142dfce361b9dc9a0b255e746'
        }
    }
};
