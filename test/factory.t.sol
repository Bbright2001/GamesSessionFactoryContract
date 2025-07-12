// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {gameSessionFactory} from "../src/gameSessionfactoryContract.sol";

contract factoryTest is Test {
    gameSessionFactory public game;

   function setUp() public {
        game = new gameSessionFactory();
    }

    //check if it deploys a contract
    function testCreatNewContract() public{
            
            game.createNewContract();

            address [] memory games = game.getDeployedContract();

            assertEq(games.length, 1);
            console.log(games.length);

            assertTrue(games[0] != address(0));

            console.log(games[0]);
    }
}