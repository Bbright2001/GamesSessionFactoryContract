
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
    event joinedGame(address _player2);
    event moveCommitted(addres _player)


    error AlreadyCommitted();
    error invalidPlayer();
    error AlreadyStarted();
   

    constructor(address _player1) {
        player1 = Player({
            addr: _player1,
            committedMoves: bytes32(0),
            revealedMoves: "",
            hasCommitted: false,
            hasRevealed: false,
            secret: ""
        });
    }

    function joinGame(address _player2) external{
        if( !(_player2 == address(0)) ) revert invalidPlayer();
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
    function commitMoves(string memory _move, string memory _secret) external {
     

        bytes32 hash = keccak256(abi.encodePacked(_move, _secret));

        if(msg.sender == player1.addr){

            if( !(player1.hasCommited) ) revert AlreadyCommitted();
            player1.committedMoves = hash;
            player1.hasCommited = true;
            player1.secret = _secret;

        }else if(msg.sender == player2.addr){

            if( !(player2.hasCommited) ) revert AlreadyCommitted();
            player2.committedMoves = hash;
            player2.hasCommited = true;
             player2.secret = _secret;
        }

        emit  moveCommitted(player);
    }
}  


contract gameSessionFactory{
    
}