pragma solidity ^0.4.24;
import './zeppelin/contracts/token/ERC20/BasicToken.sol';
import './zeppelin/contracts/ownership/Ownable.sol';
import './zeppelin/contracts/math/SafeMath.sol';

/**
 * @title Asset
 *
 * @dev The asset is an ERC20 token with unlimited supply and an additional metadata option
 */
contract Asset is BasicToken, Ownable {
    using SafeMath for uint;
    // Symbol of the asset
    string public symbol;
    // Name of the asset
    string public name;
    // Decimal precision of asset (generally 0 for non divisible assets)
    uint8 public decimals = 0;
    // Locking the token stops future minting of the token
    bool public locked = false;

    modifier canMint() {
        require(!locked, "CONTRACT LOCKED");
        _;
    }

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
    function mint(uint amount, address to) external onlyOwner canMint {
        require(to != address(0), "INVALID RECIPIENT");
        totalSupply_ = totalSupply_.add(amount);
        balances[to] = balances[to].add(amount);

        emit AssetMinted(amount, to);
        emit Transfer(address(0), to, amount);
    }

    /**
    * @dev Stop future minting of the asset
    */
    function lock() external onlyOwner {
        locked = true;

        emit Locked();
    }

    /**
    * @dev Set a metadata attribute
    * @param key The name of this metadata field
    * @param value The string value of this metadata field
    */
    function setMetadata(bytes32 key, string value) external onlyOwner {
        require(bytes(metadata[key]).length == 0, "PRE-EXISTING METADATA");
        require(bytes(value).length > 0, "METADATA EMPTY");
        metadata[key] = value;

        emit MetadataAdded(key, value);
    }

    event AssetMinted (uint amount, address to);
    event MetadataAdded (bytes32 key, string value);
    event Locked();
}
