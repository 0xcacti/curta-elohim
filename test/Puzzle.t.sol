// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Puzzle} from "../src/Puzzle.sol";
import "foundry-huff/HuffDeployer.sol";
import {Solution} from "../src/Solution.sol";

interface NERV {
    function execute(string memory command) external;
}

interface HuFFs {

    function eva_SEVEN() external pure returns(uint256);
    function eva_EIGHT() external pure returns(uint256);
    function eva_NINE() external pure returns(uint256);
    function eva_TEN() external pure returns(uint256);
}


contract PuzzleTest is Test {
    address public nerv;
    Puzzle public puzzle;

    address public huffSoln;
    HuFFs public h;


    Solution public s;

    address public me = 0xB95777719Ae59Ea47A99e744AfA59CdcF1c410a1;

    function setUp() public {
        nerv = HuffDeployer.deploy("NERVCommand");
        puzzle = new Puzzle(nerv);

        huffSoln = HuffDeployer.deploy("HuFFs");
        h = HuFFs(huffSoln);
        s = new Solution();
    }

    function testContractSize() public view {
        bytes memory code = address(huffSoln).code;
        console.log(code.length);
        assert(code.length < 222);
    }

    function testMySoln() public {
        vm.startPrank(me);
        bytes32 start = bytes32(puzzle.generate(me));
        console.log(puzzle.generateEvaConfig(me, 3));
        vm.etch(0x04208fDA37F9AC35e784287aa402446457Ee4eB7, huffSoln.code);
        console.logBytes(huffSoln.code);
        uint256 solution = 0x04208fDA37F9AC35e784287aa402446457Ee4eB71752e069AAAAAAAAAAAAAA03;
        assert(puzzle.verify(uint256(start), solution));
    }

}
