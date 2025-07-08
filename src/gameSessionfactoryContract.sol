
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

        result = GameResult.pending;
    }

    function joinGame(address _player2) external{
        if( !(_player2 == address(0)) ) revert invalidPlayer();
        if( !(hasStarted) ) revert AlreadyStarted();

        player2 = Player({
            addr: _player2;
            committedMove: ,
            hasCommitted: false,
            revealedMove: ""
            
        })

        bool hasStarted = true; 
    }
    function commitMoves(string memory _move, address _player) external {
        require(validMove(_move), "Invalid Move")

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

        //Reveal player moves

        revealMove(player1);
        revealMove(player2);
       
    }

    function validMove(string memory _move) internal pure returns (bool){
        byte32 moveHash = keccak256(bytes(_move));

        return (
            moveHash == keccak256("rock") ||
            moveHash == keccak256("scissors") ||
            moveHash == keccak256("paper")
        )
    }

    function revealMove(address player) internal returns (string){
        if(player == player1.addr){

            if( (player1.hasCommitted) )  revert mustCommit();
            player1.revealedMove = player1.committedMove;

            return player1.committedMove;
        }else if( player == player.addr){
            if( !(player2.hasCommitted) ) revert mustCommit();
              player2.revealedMove = player2.committedMove;

               return player2.committedMove;
        } else {
            "Invalid player"
        }
    }

    function declareWinner() internal {
        string memory move1 = player1.revealedMove;
        string memory move2 = player2.revealedMove;

        if(keccak256(move1) == keccak256(move2)){
            result = GameResult.Draw;
        } else if (
            compare( (move1, "rock") && compare(move2, "scissors") ) ||
            compare( (move1, "scissors") && compare(move2, "paper") ) ||
            compare( (move1, "paper") && compare(move2, "rock") )
        ){
            result = GameResult.player1Wins;
        } else {
            result = GameResult.player2wins;
        }

        bool hasEnded = true;
    }

    function compare(string memory a, string memory b) internal pure returns (bool){
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }
}

contract gameSessionFactory{
    
}