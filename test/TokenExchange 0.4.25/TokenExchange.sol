pragma solidity ^0.4.25;

import "https://github.com/tery123/grid-trading/blob/main/test/ERC20.0.4.25/interface/IERC20.sol";


contract TokenExchange {


    //From UserA, TokenA
    address fromAddress;
    address fromToken;
    uint    fromAmount;
    //From UserB, TokenB
    address toAddress;
    address toToken;
    uint    toAmount;


    //Suppose A has already approved contract
    function CreateExchange(
        address _fromToken, uint _fromAmount,
        address _toToken,   uint _toAmount) public {
            require(IERC20(_fromToken).transferFrom (msg.sender , this , _fromAmount));
            fromAddress = msg.sender;
            fromToken = _fromToken;
            fromAmount = _fromAmount;
            toToken = _toToken;
            toAmount = _toAmount;
        }

    function DoExchange() public {
        require(IERC20(fromToken).transferFrom (msg.sender , this , toAmount));
        IERC20(fromToken).transfer(msg.sender, fromAmount);
        IERC20(toToken).transfer(fromAddress,toAmount);

    }

}
