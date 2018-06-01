pragma solidity ^0.4.21;

contract CrowdFunding {
    struct Investor {
        address addr;
        uint amount;
    }

    address public owner;
    uint public numInvestors;
    uint public deadline;
    string public status;
    bool public ended;
    uint public goalAmount;
    uint public totalAmount;
    mapping (uint => Investor) public investors;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(uint _duration, uint _goalAmount) public {
        owner = msg.sender;
        deadline = now + _duration;

        goalAmount = _goalAmount;
        status = "Funding";
        ended = false;

        numInvestors = 0;
        totalAmount = 0;
    }

    function fund() payable public {
        require(!ended);

        Investor inv = investors[numInvestors++];
        inv.addr = msg.sender;
        inv.amount = msg.value;
        totalAmount += inv.amount;
    }

    function checkGoalReached() public onlyOwner {
        require(!ended);

        require(now >= deadline);

        if(totalAmount >= goalAmount) {
            status = "Campaign Succeeded";
            ended = true;
            if(!owner.send(this.balance)) {
                revert();
            }
        } else {
            uint i = 0;
            status = "Campaign Failed";
            ended = true;

            while(i <= numInvestors) {
                if(!investors[i].addr.send(investors[i].amount)) {
                    revert();
                }
                i++;
            }
        }
    }

    function kill() public onlyOwner {
        selfdestruct(owner);
    }
}
