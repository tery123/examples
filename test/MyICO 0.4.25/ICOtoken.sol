pragma solidity ^0.4.26;

import "https://github.com/tery123/examples/blob/main/contracts/math/SafeMath.sol";
import "https://github.com/tery123/examples/blob/main/test/ERC20.0.4.25/interface/IERC20.sol";

contract ICOtoken is IERC20{
    //=== liberary =================================================
    using SafeMath for uint256;
    //=== State Variables ==========================================
    string mName = "ICOtoken";
    uint8 mDecimals = 18;
    string mSymbol = "ICO";
    uint256 mTotalSupply = 0;
    mapping(address => uint256) mBalances;
    mapping(address => mapping(address => uint256)) mApprove;
    //==============================================================

    //=== Constructor ==============================================
    constructor(
        string pName,
        uint8 pDecimals,
        string pSymbol,
        uint256 pTotalSupply)
        public
    {
        mName = pName;
        mDecimals = pDecimals;
        mSymbol = pSymbol;
        mTotalSupply = pTotalSupply;
        mBalances[msg.sender] = mBalances[msg.sender].add(mTotalSupply);
        emit Transfer(address(this), msg.sender, mTotalSupply);
    } 





    function totalSupply() external view returns (uint256){
        return mTotalSupply;
    }

    //Read tokenOwner own amount of token
    function balanceOf(address tokenOwner) external view returns (uint256 balance){
        return mBalances[tokenOwner];
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
        return mApprove[tokenOwner][spender];
    }

    // tokenOwner -----> spender -----> tokens
    // address => address => uint256
    function approve(address spender, uint256 tokens) external returns (bool success){
        mApprove[msg.sender][spender] = tokens;
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
        mBalances[from] = mBalances[from].sub(tokens);
        mBalances[to] = mBalances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }
}