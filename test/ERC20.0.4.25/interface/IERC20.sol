pragma solidity ^0.4.25;

interface IERC20{
 
	function totalSupply() external view returns (uint256);

	//Read tokenOwner own amount of token
	function balanceOf(address tokenOwner) external view returns (uint256 balance);

	//From msg.sender to tokens the token 
	//msg.sender --> tokens----> to.      ->
	function transfer(address to, uint256 tokens) external returns (bool success);

	//
	function allowance(address tokenOwner, address spender) external view returns (uint256 remaining);

	// tokenOwner -----> spender -----> tokens
	// address => address => uint256
	function approve(address spender, uint256 tokens) external returns (bool success);

	function transferFrom (address from, address to, uint256 tokens) external returns(bool success);

	event Transfer(
		address indexed from,
		address indexed to,
		uint256 tokens
	);

  event Approval(
		address indexed owner,
		address indexed spender,
		uint256 tokens
  );

}