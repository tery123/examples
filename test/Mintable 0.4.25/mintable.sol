pragma solidity ^0.4.25;

import "https://github.com/tery123/examples/blob/main/test/ERC20.0.4.25/ERC20.sol";

contract mintable is ERC20 {
    address private owner;

    mapping (address => bool) minters;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyMinter(){
        require(minters[msg.sender]);
        _;
    }

    function addMinter(address addr) public onlyOwner returns (bool){
        minters[addr] = true;
        return true;
    }

    function mint(address to, uint256 tokens) public onlyMinter returns(bool) {
        //Add total supply, total supply increase.
        _totalSupply = _totalSupply.add(tokens);
        //Transfer token which additional token to someone
        _balances[to] = _balances[to].add(tokens);
        emit Transfer( address(0), to ,tokens );
        return true;
    }
}