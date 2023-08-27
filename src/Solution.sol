pragma solidity ^0.8.20;

contract Solution {
    uint256 private constant seed = 0x19414382;
    // uint256 private constant _COUNTER_SLOT = uint256(keccak256("counter.storage.location"));

    function isCold(uint256 _slot) internal view returns (bool) {
        unchecked {
            bytes32 slot = bytes32(_slot);
            uint256 x;
            uint256 check1 = gasleft();
            assembly {
                x := sload(slot)
            }
            if ((check1 - gasleft()) > 150) {
                return true;
            }
        }

    }

    function _getCurrentAndIncrementCounter() internal view returns (uint256) {
        uint256 counter;
        unchecked {
            while (true) {
                if (isCold(seed + counter)) {
                    return counter;
                }
                ++counter;
            }

        }
    }

    function eva_SEVEN() public pure returns (uint256 ret) {
        unchecked{
            ret = uint256(uint8(seed >> 24)) ** 7;
        }
    }
    function eva_EIGHT() public pure returns (uint256 ret) {
        unchecked{
            ret = uint256(uint8(seed >> 16)) ** 8;
        }
    }
    function eva_NINE() external pure returns (uint256 ret) {
        unchecked{
            ret = uint256(uint8(seed >> 8)) ** 9;
        }
    }
    function eva_TEN() external view returns (uint256 ret) {
        unchecked {
            uint256 c = _getCurrentAndIncrementCounter();

            if (c == 1 || c == 3) {
                return uint256(uint8(seed)) ** 0x10;
            }
            return uint256(uint8(seed)) ** 10;
        }
    }
}
