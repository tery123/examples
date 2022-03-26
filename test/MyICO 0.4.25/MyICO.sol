pragma solidity ^0.4.25;

import "https://github.com/tery123/examples/blob/main/contracts/math/SafeMath.sol";
import "./ICOtoken.sol";

contract MyICOContract{
    using SafeMath for uint;

    address private owner = 0x0;
    address public tokenAddress = 0x0;
    uint caps = 0; //ICO target 
    uint currentFund = 0;//current amount

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    enum ICOstate {PREPARE, START, END}
    ICOstate icoState =  ICOstate.PREPARE;

    modifier beforeICO(){
        require( icoState == ICOstate.PREPARE);
        _;
    }

    modifier whenICOStart(){
        require( icoState == ICOstate.START);
        _;
    }

    modifier whenICOend(){
        require ( icoState == ICOstate.END);
        _;
    }

    constructor() public {
        owner = msg.sender;
        string memory name = "LastToken";
        uint8 decimal = 18;
        string memory symbol = "LTT";
        uint256 totalSupply = 1000 * (10 ** 18);
        caps = totalSupply;

        tokenAddress = new ICOtoken(name, decimal, symbol, totalSupply);
    }

    function startICO() public onlyOwner beforeICO {
        icoState = ICOstate.START;
    }

    function endICO() public onlyOwner whenICOStart{
        icoState = ICOstate.END;
        owner.transfer(address(this).balance);
        IERC20(tokenAddress).transfer( owner, caps.sub(currentFund) );
    }

    function() public payable whenICOStart{
        require(msg.value > 0);
        require(caps.sub(currentFund) >= msg.value);
        currentFund = currentFund.add(msg.value);
        IERC20(tokenAddress).transfer(msg.sender, msg.value);
    }

}