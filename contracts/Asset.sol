pragma solidity ^0.4.23;
import './zeppelin/contracts/token/ERC20/StandardToken.sol';
import './zeppelin/contracts/ownership/Ownable.sol';
import './zeppelin/contracts/math/SafeMath.sol';

/**
 * @title Asset
 *
 * @dev The asset is an ERC20 token with unlimited supply and an additional metadata option
 */
contract Asset is StandardToken, Ownable {
    using SafeMath for uint;

    string public symbol;
    string public name;
    uint8 public decimals = 0;
    // Locking the token stops future minting of the token
    bool public locked = false;

    // Suggested Standard Metadata
    // =======================================================
    // Metadata is used to give some predetermined information
    // about an asset and is recommended to implement the
    // following as a base level to add depth to the asset.
    // =======================================================
    // icon - IPFS Hash to an icon in PNG format of the asset
    // model - IPFS Hash to an .obj file of the asset
    // version - Iteration of the item
    // rarity - How rare is this item?
    // description - Lore or short description behind the item
    mapping(bytes32 => string) public metadata;

    constructor(string _symbol, string _name) public {
        symbol = _symbol;
        name = _name;
    }

    /**
    * @dev Mint new asset(s) to an address
    * @param amount The amount of the asset to mint
    * @param to The address to mint to.
    */
    function mint(uint amount, address to) external onlyOwner {
        require(locked == false, "CONTRACT LOCKED");
        totalSupply_ = totalSupply_.add(amount);
        balances[to] = balances[to].add(amount);
    }

    /**
    * @dev Stop future minting of the asset
    */
    function lock() external onlyOwner {
        locked = true;
    }

    /**
    * @dev Set a metadata attribute
    * @param key The name of this metadata field
    * @param value The string value of this metadata field
    */
    function setMetadata(bytes32 key, string value) external onlyOwner {
        require(bytes(metadata[key]).length == 0, "PRE-EXISTING METADATA");
        metadata[key] = value;
    }
}
