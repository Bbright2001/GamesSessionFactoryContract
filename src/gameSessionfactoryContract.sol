
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract rockPaperScissorsGame{

    struct Player{
        address addr;
        bytes32 committedMoves;
        string  revealedMoves;
        bool hasCommitted;
        bool hasRevealed;
        string secret; 
    }
    Player public player1;
    Player player2;
    bool hasStarted;
    bool hasended;


    event Winner(address _player);
    event joinedGame(adrress _player2);


    error playerHasNotCommitted();
    error invalidPlayerAddress();
    error AlreadyStarted();
   

    constructor(address _player1) {
        player1 = Player({
            addr: _player1,
            committedMoves: bytes32(0),
            revealedMoves: "",
            hasCommited: false,
            hasRevealed: false,
            secret: ""
        });
    }

    function joinGame(address _player2) external{
        if( !(_player2 == address(0)) ) revert invalidPlayerAddress();
        if( !(hasStarted) ) revert AlreadyStarted();

        player2 = Player({
            addr: _player2;
            committedMoves: bytes32(0),
            revealedMoves: "",
            hasCommited: false,
            hasRevealed: false,
            secret: ""
        })

        bool hasStarted = true;
    }
} 


contract gameSessionFactory{
    
}