pragma solidity ^0.5.0;

interface IUniswapFactory {
  event NewToken(uint256 token_id, address indexed owner, address indexed token);

  function initializeFactory(address template) external;
  function createToken() external returns (address payable);
  function getToken(address owner) external view returns (address payable);
  function getOwner(address token) external view returns (address);
  function getTokenWithId(uint256 token_id) external view returns (address);
}