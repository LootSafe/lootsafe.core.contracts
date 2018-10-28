pragma solidity ^0.4.23;
import './zeppelin/contracts/ownership/Ownable.sol';
import './Asset.sol';

/**
 * @title Registry
 *
 * @dev The registry represents a party that owns a list of assets within the system
 */
contract Registry is Ownable {
  // Owner of the registry, usually a studio or publisher
  address public owner;
  // List of all assets registered.
  mapping(bytes32 => address) public assetAddresses;
  // A list of all asset short names registered.
  bytes32[] public assets;


  constructor() public {
    owner = msg.sender;
  }

  /**
  * @dev Get a list of all assets within registry
  */
  function getAssets () public view returns (bytes32[]) {
    return assets;
  }

  /**
  * @dev Create a new asset within this registry
  * @param symbol The symbol for this asset
  * @param name The name of the asset
  */
  function create(string symbol, string name, bytes32 shortName) external onlyOwner {
    require(assetAddresses[shortName] == 0x0, "ASSET NAME RESERVED");
    Asset newAsset = new Asset(symbol, name);
    assets.push(shortName);
    assetAddresses[shortName] = address(newAsset);
  }
}
