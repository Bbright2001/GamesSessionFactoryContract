
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract rockPaperScissorGame{

    enum GameResult{pending, Draw, player1Wins, player2Wins}

    struct Player{
        address addr;
        string committedMove;
        bool hasCommitted;
        string revealedMove;
    }
    Player public player1;
    Player public player2;
    bool public hasStarted;
    bool public  hasEnded;

    GameResult public result;


    event Winner(address _player);
    event joinedGame(address _player2);
    event moveCommitted();


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
            addr: _player2,
            committedMove: "",
            hasCommitted: false,
            revealedMove: ""
            
        });

         hasStarted = true; 
    }
    function commitMoves(string memory _move) external {
        require(validMove(_move), "Invalid Move");

        if(msg.sender == player1.addr){

            if( !(player1.hasCommitted) ) revert AlreadyCommitted();
            player1.committedMove = _move;
            player1.hasCommitted = true;

        }else if(msg.sender == player2.addr){

            if( !(player2.hasCommitted) ) revert AlreadyCommitted();
            player2.committedMove = "";
            player2.hasCommitted = true;

        } else{

            
        }

        emit  moveCommitted();

        //Reveal player moves

        revealMove(player1.addr);
        revealMove(player2.addr);
       
       // Announce Winner
        declareWinner();

          hasEnded = true;
    }

    function validMove(string memory _move) internal pure returns (bool){
        bytes32 moveHash = keccak256(bytes(_move));

        return (
            moveHash == keccak256("rock") ||
            moveHash == keccak256("scissors") ||
            moveHash == keccak256("paper")
        );
    }

    function revealMove(address player) internal returns(string memory) {
        if(player == player1.addr){

            if( (player1.hasCommitted) )  revert mustCommit();
            player1.revealedMove = player1.committedMove;

            return (player1.committedMove);
        }else if( player == player2.addr){
            if( !(player2.hasCommitted) ) revert mustCommit();
              player2.revealedMove = player2.committedMove;

               return (player2.committedMove);
        } else {
            return ("Invalid player");
        }
    }

    function declareWinner() internal {
        string memory move1 = player1.revealedMove;
        string memory move2 = player2.revealedMove;

        if(keccak256(bytes(move1)) == keccak256(bytes(move2))){
            result = GameResult.Draw;
        } else if (
            compare(move1, "rock") && compare(move2, "scissors") ||
            compare (move1, "scissors") && compare(move2, "paper")  ||
            compare (move1, "paper") && compare(move2, "rock") 
        ){
            result = GameResult.player1Wins;
        } else {
            result = GameResult.player2Wins;
        }
    }
     function compare(string memory a, string memory b) internal pure returns (bool){
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }

    }

   


contract gameSessionFactory{
    // array to store address of deployed child contracts

    address [] public deployedGameSession;


    event newGameSessionCreated(address indexed newGame, address indexed creator);

    function createNewContract() external returns (address){

        rockPaperScissorGame  newGameSession = new rockPaperScissorGame(msg.sender);

        deployedGameSession.push(address(newGameSession));


        emit newGameSessionCreated(address(newGameSession), msg.sender);

        return address(newGameSession);
    }

    //function to get all deployed game

    function getAllChildContractAddress() external view returns (uint256){
        return deployedGameSession.length;
    }
    
}