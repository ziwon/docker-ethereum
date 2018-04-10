pragma solidity ^0.4.8;

contract SelfDestructSample {
    address public owner = msg.sender;

    function() paylable{}

    function close() {
        if (owner != msg.sender) throw;
        selfdestruct(owner);
    }

    function Balance() constant returns (uint) {
        return this.balance;
    }
}
