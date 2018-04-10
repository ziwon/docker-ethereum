pragma solidity ^0.4.16;
pragma experimental "v0.5.0";
pragma experimental "ABIEncoderV2";

library Bits {

    uint constant internal ONE = uint(1);
    uint constant internal ONES = uint(~0);

    function setBit(uint self, uint8 index) internal pure returns (uint) {
        return self | ONE << index;
    }

    function clearBit(uint self, uint8 index) internal pure returns (uint) {
        return self & ~(ONE << index);
    }

    function toggleBit(uint self, uint8 index) internal pure returns (uint) {
        return self ^ ONE << index;
    }

    function bit(uint self, uint8 index) internal pure returns (uint8) {
        return uint8(self >> index & 1);
    }

    function bitSet(uint self, uint8 index) internal pure returns (bool) {
        return self >> index & 1 == 1;
    }

    function bitEqual(uint self, uint other, uint8 index) internal pure returns (bool) {
        return (self ^ other) >> index & 1 == 0;
    }

    function bitNot(uint self, uint8 index) internal pure returns (uint8) {
        return uint8(1 - (self >> index & 1));
    }

    function bitAnd(uint self, uint other, uint8 index) internal pure returns (uint8) {
        return uint8((self & other) >> index & 1);
    }

    function bitOr(uint self, uint other, uint8 index) internal pure returns (uint8) {
        return uint8((self | other) >> index & 1);
    }

    function bitXor(uint self, uint other, uint8 index) internal pure returns (uint8) {
        return uint8((self ^ other) >> index & 1);
    }

    // Gets 'numBits' consecutive bits from 'self', starting from the bit at 'startIndex'.
    // Returns the bits as a 'uint'.
    // Requires that:
    //  - '0 < numBits <= 256'
    //  - 'startIndex < 256'
    //  - 'numBits + startIndex <= 256'
    function bits(uint self, uint8 startIndex, uint16 numBits) internal pure returns (uint) {
        require(0 < numBits && startIndex < 256 && startIndex + numBits <= 256);
        return self >> startIndex & ONES >> 256 - numBits;
    }

    function highestBitSet(uint self) internal pure returns (uint8 highest) {
        require(self != 0);
        uint val = self;
        for (uint8 i = 128; i >= 1; i >>= 1) {
            if (val & (ONE << i) - 1 << i != 0) {
                highest += i;
                val >>= i;
            }
        }
    }

    function lowestBitSet(uint self) internal pure returns (uint8 lowest) {
        require(self != 0);
        uint val = self;
        for (uint8 i = 128; i >= 1; i >>= 1) {
            if (val & (ONE << i) - 1 == 0) {
                lowest += i;
                val >>= i;
            }
        }
    }
}
