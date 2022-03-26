pragma solidity ^0.4.25;

import "https://github.com/tery123/grid-trading/blob/main/test/ERC20.0.4.25/ERC20.sol";

contract burnable is ERC20 {
  
    event Burn(address account, uint256 tokens );

    function burn(uint256 tokens) public returns(bool) {
        //Check the tokens has enough amount to burn
        require(tokens <= _balances[msg.sender]);

        //Burn self token. Decrease total supply
        _totalSupply = _totalSupply.sub(tokens);
        //Decrase balance of msg.sender
        _balances[msg.sender] = _balances[msg.sender].sub(tokens);
        
        emit Burn(msg.sender , tokens);
        emit Transfer( msg.sender, address(0) ,tokens );
        
        return true;
    }
}