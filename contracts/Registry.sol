pragma solidity ^0.4.23;
import './zeppelin/contracts/ownership/Ownable.sol';
import './Asset.sol';

/**
 * @title Registry
 *
 * @dev The registry represents a party that owns a list of assets within the system
 */
contract Registry is Ownable {
  address public owner;

  mapping(bytes32 => address) public assetAddresses;
  bytes32[] public assets;

  constructor() public {
    owner = msg.sender;
  }


  function getAssets () public view returns (bytes32[]) {
    return assets;
  }

  /**
  * @dev Create a new asset within this registry
  * @param symbol The symbol for this asset
  * @param name The name of the asset
  */
  function create(string symbol, string name, bytes32 shortname) external onlyOwner {
    require(assetAddresses[shortname] == 0x0, "ASSET NAME RESERVED");
    Asset newAsset = new Asset(symbol, name);
    assets.push(shortname);
    assetAddresses[shortname] = address(newAsset);
  }
}
