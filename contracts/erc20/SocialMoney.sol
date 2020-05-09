pragma solidity ^0.5.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract SocialMoney is ERC20, ERC20Detailed {
  uint public INITIAL_SUPPLY = 21000;
  address public owner;

  constructor(string memory _name, string memory _symbol, uint8 _decimals)
    ERC20Detailed(_name, _symbol, _decimals)
    public
  {
    _mint(msg.sender, INITIAL_SUPPLY);
    owner = msg.sender;
  }
}