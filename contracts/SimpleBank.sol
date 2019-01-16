pragma solidity ^0.5.0;
contract SimpleBank {
    
    mapping (address => uint) private balances;
    mapping (address => bool) public enrolled;
    address public owner;
    
    event LogEnrolled(address accountAddress);
    event LogDepositMade(address accountAddress, uint amount);
    event LogWithdrawal(address accountAddress, uint withdrawAmount, uint newBalance);

    constructor() public {
        owner = msg.sender;
    }

    function balance() public view returns (uint) {
        return balances[msg.sender];
    }

    function enroll() public returns (bool){
        enrolled[msg.sender] = true;
        emit LogEnrolled(msg.sender);
        return enrolled[msg.sender];

    }

    function deposit() public payable returns (uint) {
            balances[msg.sender] += msg.value;
    emit LogDepositMade(msg.sender, msg.value);
    return balances[msg.sender];
    }

    function withdraw(uint withdrawAmount) public payable returns (uint newBalance) {
            if (withdrawAmount <= balances[msg.sender]) {
            balances[msg.sender] -= withdrawAmount;
            msg.sender.transfer(withdrawAmount);
            emit LogWithdrawal(msg.sender, withdrawAmount, newBalance);
        }
        return balances[msg.sender];
}

    function() external {
        revert();
    }
}
