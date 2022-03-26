pragma solidity ^0.4.25;

import "https://github.com/tery123/examples/blob/main/contracts/math/SafeMath.sol";

contract MiningShare{
    using SafeMath for uint;

    //Convener
    address private owner = 0x0;
    //Convening time.
    uint private closeBlock = 0x0;
    //Investor
    //1. The amount of investment
    mapping( address => uint ) private userNTD;
    //2. The amount of Withdraw
    mapping( address => uint) private userWithdraw;
    //Log 
    //1. The amount of total investment
    uint private totalNTD = 0;
    //2. The amount of total Withdraw
    uint private totalWithdraw = 0;

    //The function of convener
    constructor() public {
        owner = msg.sender;
        closeBlock = block.number + 2000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier beforeCloseBlock() {
        require(block.number < closeBlock);
        _;
    }

    modifier afterCloseBlock() {
        require(block.number > closeBlock);
        _;
    }

    modifier onlyShareHolder() {
        require(userNTD[msg.sender] != 0 );
        _;
    }

    function CapitalIncrease(address account, uint NTD) public onlyOwner{
        userNTD[account] = userNTD[account].add(NTD);
        totalNTD = totalNTD.add(NTD);
    }

    function CapitalDecrease(address account, uint NTD) public onlyOwner{
        userNTD[account] = userNTD[account].sub(NTD);
        totalNTD = totalNTD.sub(NTD);
    }

    function MyTotalNTD() public constant onlyShareHolder returns(uint){
        return userNTD[msg.sender];
    }

    function MyTotalWithdraw() public constant onlyShareHolder afterCloseBlock returns(uint){
        return userNTD[msg.sender];
    }

    function TotalMind() public constant onlyShareHolder afterCloseBlock returns(uint){
        return totalWithdraw.add(address(this).balance);
    }

    function Withdraw() public onlyShareHolder afterCloseBlock {
        uint totalMined = totalWithdraw.add(address(this).balance);
        //totalMined * hisNTD / totalNTD - userWithdraw
        uint userCanWithaw = totalMined.mul(userNTD[msg.sender].div(
            totalNTD)).sub(
                userWithdraw[msg.sender]);
        
        userWithdraw[msg.sender].add(userCanWithaw);
        totalWithdraw.add(userCanWithaw);
        msg.sender.transfer(userCanWithaw);
            
    }

}