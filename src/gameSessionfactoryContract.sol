
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract rockPaperScissorsGame{

    enum GameResult = (pending, Draw, player1Wins, player2Wins);

    struct Player{
        address addr;
        string committedMove;
        bool hasCommitted;
        string revealMove;
    }
    Player public player1;
    Player public player2;
    bool public hasStarted;
    bool public  hasended;

    GameResult public result;


    event Winner(address _player);
    event joinedGame(address _player2);
    event moveCommitted(addres _player)


    error AlreadyCommitted();
    error mustCommit();
    error invalidPlayer();
    error AlreadyStarted();
    error wrongHash();
   

    constructor(address _player1) {
        player1 = Player({
            addr: _player1,
            committedMove: "",
            hasCommitted: false,
            revealedMove: ""
        });

        result = result.pending;
    }

    function joinGame(address _player2) external{
        if( !(_player2 == address(0)) ) revert invalidPlayer();
        if( !(hasStarted) ) revert AlreadyStarted();

        player2 = Player({
            addr: _player2;
            committedMove: ,
            hasCommited: false,
            revealedMove ""
            
        })

        bool hasStarted = true; 
    }
    function commitMoves(string memory _move, address _player) external {
     

        // bytes32 hash = keccak256(abi.encodePacked(_move, _secret));

        if(msg.sender == player1.addr){

            if( !(player1.hasCommited) ) revert AlreadyCommitted();
            player1.committedMove = _move;
            player1.hasCommitted = true;

        }else if(msg.sender == player2.addr){

            if( !(player2.hasCommited) ) revert AlreadyCommitted();
            player2.committedMove = hash;
            player2.hasCommitted = true;

        } else{

            "invalid Player";
        }

        emit  moveCommitted(_player);
       
    }

}

contract gameSessionFactory{
    
}