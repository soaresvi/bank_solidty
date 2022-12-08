pragma solidity ^0.8.17;

interface USDC {

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

}

contract main{
    USDC public USDc;
    address owner;
    mapping(address => uint) public stakingBalance;

    constructor() {
        USDc = USDC(0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6);
        owner = msg.sender;
    }


    function depositTokens(uint $USDC) public {

        // amount should be > 0

        // transfer USDC to this contract
        //USDc.approve(address(this), $USDC);
        USDc.transferFrom(msg.sender, address(this), $USDC);
        
        // update staking balance
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + $USDC;
    }

    // Unstaking Tokens (Withdraw)
    function withdrawalTokens() public {
        uint balance = stakingBalance[msg.sender];

        // balance should be > 0
        require (balance > 0, "staking balance cannot be 0");

        // Transfer USDC tokens to the users wallet
        USDc.transfer(msg.sender, balance);

        // reset balance to 0
        stakingBalance[msg.sender] = 0;
    }
}
