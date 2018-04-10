pragma solidity ^0.4.8;

contract AddressSample {

    function() paylable {}

    function getBalance(address _target) constant returns (uint) {
        if (_target == address(0)) {
            _target = this;
        }

        return _target.balance;
    }

    function send(address _to, uint _amount) {
        if(!_to.send(_amount)) {
            throw;
        }
    }

    function withdraw() {
        address to = msg.sender;
        to.transfer(this.balance);
    }

    function withdraw2() {
        address to = msg.sender;
        if(!to.call.value(this.balance).gas(1000000)()) {
            throw;
        }
    }
}
