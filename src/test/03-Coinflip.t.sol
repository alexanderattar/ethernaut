// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "ds-test/test.sol";
import "forge-std/Vm.sol";

import "../levels/03-Coinflip/CoinflipAttack.sol";
import "../levels/03-Coinflip/CoinflipFactory.sol";
import "../core/Ethernaut.sol";

contract CoinflipTest is DSTest {
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

    function testCoinflipHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////
        CoinflipFactory coinflipFactory = new CoinflipFactory();
        ethernaut.registerLevel(coinflipFactory);
        vm.startPrank(attacker);

        address levelAddress = ethernaut.createLevelInstance(coinflipFactory);
        Coinflip coinflipContract = Coinflip(levelAddress);

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
