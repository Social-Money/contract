pragma solidity ^0.5.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract SocialMoney is ERC20, ERC20Detailed {
  // uint public INITIAL_SUPPLY = 1e18;
  address public owner;

  constructor(string memory _name, string memory _symbol, uint8 _decimals, uint total_supply)
    ERC20Detailed(_name, _symbol, _decimals)
    public
  {
    _mint(msg.sender, total_supply);
    owner = msg.sender;
  }
}