// SPDX-License-Identifier: MIT

// Get funds from users
// Withdraw funds
// Set a minimum funding vaue in USD

pragma solidity ^0.8.18;

contract FundMe {

    uint256 constant MINIMUM_USD = 5;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        msg.value.getConversionRate();
        require(msg.value >= MINIMUM_USD, "didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;

    }

    //function withdraw() public {}

    function getPrice() internal view returns(uint256){
        // Address
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface()
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        //msg.value/getConversionRate()
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;

    }
    
    function withdraw() public {
        // for loop
        // [1, 2, 3, ] elements
        // [0, 1, 2, 3] indexes
        // for(/* starting index, ending index, step amunt */ )
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);
        // actually withdraw the funds

        // 1. transfer
        // 2. send
        // 3. call

        // 1. transfer
        // msg. sender = address
        // payable(msg.sender) = payable address
        payable(msg.sender).transfer(address(this).balance);

        // 2. send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send Failed");

        // 3. call - for the most part use the Call method
        (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "sender is not owner");
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

}

