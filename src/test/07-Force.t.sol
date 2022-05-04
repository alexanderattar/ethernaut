// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "ds-test/test.sol";
import "forge-std/Vm.sol";

import "../levels/07-Force/ForceAttack.sol";
import "../levels/07-Force/ForceFactory.sol";
import "../core/Ethernaut.sol";

contract ForceTest is DSTest {
    //////////////////
    //  GAME SETUP  //
    //////////////////

    Vm vm = Vm(address(HEVM_ADDRESS)); // `ds-test` library cheatcodes for testing
    Ethernaut ethernaut;
    address attacker = address(0xdeadbeef);

    function setUp() public {
        ethernaut = new Ethernaut(); // initiate Ethernaut contract instance
        vm.deal(attacker, 1 ether); // fund our attacker contract with 1 ether
    }

    function testForceHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        ForceFactory forceFactory = new ForceFactory();
        ethernaut.registerLevel(forceFactory);
        vm.startPrank(attacker);

        address levelAddress = ethernaut.createLevelInstance(forceFactory);
        Force forceContract = Force(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        bool challengeCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(challengeCompleted);
    }
}
