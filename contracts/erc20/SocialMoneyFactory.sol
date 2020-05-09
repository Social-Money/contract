pragma solidity ^0.5.6;

import "./SocialMoney.sol";
import "../interfaces/ISocialMoneyFactory.sol";


contract SocialMoneyFactory {

  /***********************************|
  |       Events And Variables        |
  |__________________________________*/

  event NewToken(address indexed owner, address indexed token);

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

  function createToken(string memory _name, string memory _symbol) public returns (address) {
    address owner = msg.sender;
    require(owner != address(0));
    require(tokenTemplate != address(0));
    require(owner_to_token[owner] == address(0));
    SocialMoney token = new SocialMoney(_name, _symbol, 18);
    owner_to_token[owner] = address(token);
    token_to_owner[address(token)] = owner;
    uint256 token_id = tokenCount + 1;
    tokenCount = token_id;
    id_to_token[token_id] = address(token);
    emit NewToken(owner, address(token));
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
