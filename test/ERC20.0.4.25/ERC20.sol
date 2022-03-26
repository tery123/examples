pragma solidity ^0.4.26;

import "https://github.com/tery123/grid-trading/blob/main/contracts/math/SafeMath.sol";
import "https://github.com/tery123/grid-trading/blob/main/test/ERC20.0.4.25/interface/IERC20.sol";

contract ERC20 is IERC20{
    using SafeMath for uint256;

    string public constant name = "baby token";
    uint8 public constant deciamls = 18;
    string public constant symbol = "BBT";

    mapping(address => uint256) _balances;
    mapping(address => mapping(address => uint256)) _approve;

    //uint256 private _totalSupply;
    uint256 internal _totalSupply; //must inheritance

    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }

    //Read tokenOwner own amount of token
    function balanceOf(address tokenOwner) external view returns (uint256 balance){
        return _balances[tokenOwner];
    }

    //From msg.sender to tokens the token 
    //msg.sender --> tokens----> to.      ->
    function transfer(address to, uint256 tokens) external returns (bool success){
        //_balances[msg.sender] = _balances[msg.sender].sub(tokens);
        //_balances[to] =_balances[msg.sender].add(tokens);
        //emit Transfer(msg.sender, to, _balances[msg.sender] );
        //return true;
        return _transfer(msg.sender, to, tokens);
    }

    //
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining){
        return _approve[tokenOwner][spender];
    }

    // tokenOwner -----> spender -----> tokens
    // address => address => uint256
    function approve(address spender, uint256 tokens) external returns (bool success){
        _approve[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender ,tokens);
        return true;
    }

    function transferFrom (address from, address to, uint256 tokens) external returns(bool success){
        //_approve[from][msg.sender] = _approve[from][msg.sender].sub(tokens);
        //_balances[from] = _balances[from].sub(tokens);
        //emit Transfer(from, to, tokens);
        //return true;
        return _transfer( from, to, tokens);
    }

    function _transfer(address from, address to, uint256 tokens) internal returns (bool success){
        _balances[from] = _balances[from].sub(tokens);
        _balances[to] =_balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }
}