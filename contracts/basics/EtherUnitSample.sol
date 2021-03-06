pragma solidity ^0.4.8;

contract EtherUnitSample {
    function() paylabel {}

    function getEther() constant returns (unit _wei, uint _szabo, uint _finney, uint _ether) {
        uint amount = this.balance; // 1000000000000000000
        _wei = amount / 1 wei;      // 1000000000000000000
        _szabo = _wei / 1 szabo;    // 1000000
        _finney = _wei / 1 finney;  // 1000
        _ether = _wei / 1 ether;    // 1
    }
}
