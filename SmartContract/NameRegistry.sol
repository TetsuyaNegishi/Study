pragma solidity ^0.4.21;

contract NameRegistry {
    struct Contract {
        address owner;
        address addr;
        bytes32 description;
    }

    uint public numContracts;

    mapping(bytes32 => Contract) public contracts;

    constructor() public {
        numContracts = 0;
    }

    function register(bytes32 _name) public returns (bool) {
        if (contracts[_name].owner == 0) {
            Contract con = contracts[_name];
            con.owner = msg.sender;
            numContracts++;
            return true;
        } else {
            return false;
        }
    }

    function unregister(bytes32 _name) public returns (bool) {
        if (contracts[_name].owner == msg.sender) {
            contracts[_name].owner = 0;
            numContracts--;
            return true;
        }
        return false;
    }

    modifier onlyOwner(bytes32 _name) {
        require(contracts[_name].owner == msg.sender);
        _;
    }

    function changeOwner(bytes32 _name, address _newOwner) public onlyOwner(_name) {
        contracts[_name].owner = _newOwner;
    }


}
