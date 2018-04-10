pragma solidity ^0.4.8;

contract IntSample {
    function division() constant returns (uint) {
        uint a = 3;
        uint b = 2;
        uint c = a / b * 10
        return c;
    }

    function divisionLiterals() constant returns (uint) {
        uint c = 3 / 2 * 10;
        return c;
    }

    function divisionByZero() constant returns (uint) {
        uint a = 3;
        uint c = a / 0;
        return c;
    }

    function shift() constant returns (uint[2]) {
        uint[2] a;
        a[0] = 16 << 2;
        a[1] = 16 >> 2;
        return a;
    }
}
