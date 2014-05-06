var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

(function(root){
  var TicTacToe = root.TicTacToe = (root.TicTacToe || {});

  var Board = TicTacToe.Board = function() {
    this.board = [
      [null, null, null],
      [null, null, null],
      [null, null, null]
    ];

    this.print = function() {
      for (var i = 0; i < 3; i++) {
        var rowStr = "";
        for (var j = 0; j < 3; j++) {
          if (this.board[i][j] === null){
            rowStr += "* ";
          } else {
            rowStr += (this.board[i][j] + " ");
          };
        };
        console.log(rowStr);
      };
    };
  };

  var Player = TicTacToe.Player = function(char) {
    this.char = char;
    this.type = "Human";
  };

  var Computer = TicTacToe.Computer = function(char) {
    this.char = char;
    this.type = "Computer";
  };

  var Game = TicTacToe.Game = function(player1, player2, board) {
    this.player1 = player1;
    this.player2 = player2;
    this.board = board;
    this.playerQueue = [player1, player2];
    this.currentPlayer = this.playerQueue[0];
  };

  Game.prototype.play = function() {
    var won = function(){

      //best code award
      for (var i = 0; i < 3; i++){
        var currentRow = this.board.board[i];
        if (currentRow[0] === null ) {
          continue;
        } else if (currentRow[0] === currentRow[1] && currentRow[1] === currentRow[2]) {
          return currentRow[0];
        };
      };

      for (var i = 0; i < 3; i++){
        var currentColumn = [this.board.board[0][i], this.board.board[1][i], this.board.board[2][i]];
        if (currentColumn[0] === null ) {
          continue;
        } else if (currentColumn[0] === currentColumn[1] && currentColumn[1] === currentColumn[2]) {
          return currentColumn[0];
        };
      };

      if ((this.board.board[0][0]===this.board.board[1][1] && this.board.board[1][1] === this.board.board[2][2]) && this.board.board[0][0] !== null) {
        return this.board.board[0][0];
      } else if ((this.board.board[0][2]===this.board.board[1][1] && this.board.board[1][1] === this.board.board[2][0]) && this.board.board[0][2] !== null) {
        return this.board.board[0][2];
      };

      return false;
    };

    var tied = function() {
      var flat = this.board.board.reduce(function(a,b){
        return a.concat(b);
      });
      return (flat.indexOf(null) === -1);
    };

    if (won.bind(this)()){
      this.board.print();;
      console.log("You won! " + won.bind(this)());
      reader.close();

    } else if (tied.bind(this)()) {
      this.board.print();
      console.log("You've tied!");
      reader.close();
    } else {
      this.board.print();
      this.playerQueue.reverse();
      this.currentPlayer = this.playerQueue[0];
      this.place(this.currentPlayer.char);
    };
  };

  Game.prototype.place = function(char) {

    var theGame = this;

    var questionStr = char + "'s turn: ";

    reader.question(questionStr, function(strCoordinates){
      var cleanCoor = strCoordinates.match(/(\d).*(\d)/).slice(1, 3);
      var x = cleanCoor[0];
      var y = cleanCoor[1];

      //checks if space is occupied &&
      //checks if space is within board
      if( !theGame.board.board[x][y] && (x <= 2 && y <= 2) ){
        theGame.board.board[x][y] = char;

        theGame.play();
      } else {
        console.log("invalid move");
        theGame.place(char);
      };
    });
  };

})(this);

ply1 = new this.TicTacToe.Player('X');
ply2 = new this.TicTacToe.Player('O');
board = new this.TicTacToe.Board();
game = new this.TicTacToe.Game(ply1, ply2, board);

game.play();