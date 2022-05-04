// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "ds-test/test.sol";
import "forge-std/Vm.sol";

import "../levels/04-Telephone/TelephoneAttack.sol";
import "../levels/04-Telephone/TelephoneFactory.sol";
import "../core/Ethernaut.sol";

contract TelephoneTest is DSTest {
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

    function testTelephoneHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        TelephoneFactory telephoneFactory = new TelephoneFactory();
        ethernaut.registerLevel(telephoneFactory);
        vm.startPrank(attacker);

        address levelAddress = ethernaut.createLevelInstance(telephoneFactory);
        Telephone telephoneContract = Telephone(levelAddress);

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
