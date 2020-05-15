pragma solidity ^0.5.6;

import "./SocialMoney.sol";
import "../interfaces/ISocialMoneyFactory.sol";


contract SocialMoneyFactory {

  /***********************************|
  |       Events And Variables        |
  |__________________________________*/

  event NewToken(uint256 token_id, address indexed owner, address indexed token, uint total_supply, string name, string symbol, uint decimals);

  address public tokenTemplate;
  uint256 public tokenCount;
  mapping (address => address) internal owner_to_token;
  mapping (address => address) internal token_to_owner;
  mapping (uint256 => address) internal id_to_token;

  /***********************************|
  |         Factory Functions         |
  |__________________________________*/
  constructor(address template) public {
    require(tokenTemplate == address(0), "tokenTemplate must not be zero address");
    require(template != address(0), "template must not be zero address");
    tokenTemplate = template;
  }

  /* function initializeFactory(address template) public {
    require(exchangeTemplate == address(0));
    require(template != address(0));
    exchangeTemplate = template;
  } */

  function createToken(string memory name, string memory symbol) public returns (address) {
    uint total_supply = 21000000;
    uint8 decimals = 4;
    address owner = msg.sender;
    require(owner != address(0));
    require(tokenTemplate != address(0));
    require(owner_to_token[owner] == address(0), "you already created token");
    SocialMoney token = new SocialMoney(name, symbol, decimals, total_supply);
    token.transfer(owner, total_supply);
    owner_to_token[owner] = address(token);
    token_to_owner[address(token)] = owner;
    uint256 token_id = tokenCount + 1;
    tokenCount = token_id;
    id_to_token[token_id] = address(token);
    emit NewToken(token_id, owner, address(token), total_supply, name, symbol, decimals);
    return address(token);
  }

  /***********************************|
  |         Getter Functions          |
  |__________________________________*/

  function getToken(address owner) public view returns (address) {
    return owner_to_token[owner];
  }

  function getOwner(address token) public view returns (address) {
    return token_to_owner[token];
  }

  function getTokenWithId(uint256 token_id) public view returns (address) {
    return id_to_token[token_id];
  }

}

