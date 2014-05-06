var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

(function (root){
  var Hanoi = root.Hanoi = (root.Hanoi || {});

  var Game = Hanoi.Game = function(numberDisks, numberPegs) {
    this.board = new Array();
    this.numberDisks = numberDisks;

    for(var i = 0; i < numberPegs; i++){
      this.board.push(new Array());
    };

    for(var i = numberDisks; i > 0; i--){
      this.board[0].push(i);
    };
  };


  Game.prototype.play = function(){

    var won = function(){
      return (this.board[this.board.length - 1].length === this.numberDisks);
    };

    if (won.bind(this)()){
      console.log("You won!");
      reader.close()

    } else {

      console.log(this.board);
      this.move();

    };
  };

  Game.prototype.move = function(){
    var ourGame = this;

    var isValidMove = function(start, end){
      var moveFrom = ourGame.board[start][ourGame.board[start].length - 1];
      var moveTo = ourGame.board[end][ourGame.board[end].length - 1];

      if (!ourGame.board[start]) {

        return false;

      } else if (!moveTo) {

        return true;

      } else if (moveTo > moveFrom) {

        return true;

      } else {

        return false;

      };
    };

    reader.question("Enter coordinates for move: ", function(strCoordinates){
      cleanCoor = strCoordinates.match(/(\d).*(\d)/).slice(1, 3);
      var start = parseInt(cleanCoor[0]);
      var end = parseInt(cleanCoor[1]);

      if (isValidMove(start, end)){

        ourGame.board[end].push(
          ourGame.board[start].pop()
        );

        ourGame.play();

      } else {

        console.log("nah bruh");
        ourGame.move();

      };
    });
  };

  // var game = new Game(2,3);

  // game.play(function() {
  //   console.log("you won");
  // });

  // game.play()

})(this);

my_game = new this.Hanoi.Game(2,3)
my_game.play()

// 1. ourGame is bad -- switch over to 'call' so we can use 'this'
// 2. completionCallback ain't havin' it
// 3. Why did we have to wrap everything and/or what did we do wrong