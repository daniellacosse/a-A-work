function Game(){}
function Board(){
  this.board = [];
  for(var i = 0; i < 8; i++){
    this.board.push([]);
    for(var j = 0; j < 8; j++){
      this.board[i].push(null);
    }
  }

  this.board[3][4] = new Piece('b', [3, 4], this);
  this.board[4][3] = new Piece('b', [4, 3], this);
  this.board[3][3] = new Piece('w', [3, 3], this);
  this.board[4][4] = new Piece('w', [4, 4], this);

  // brd = [];
  // for(var i = 0; i < 8; i++){
  //   brd.push([]);
  //   for(var j = 0; j < 8; j++){
  //     brd[i].push(null);
  //   }
  // }

 this.makeMove = //

 this.placePiece = function(position, color){
   this.board[position[0]][position[1]] = new Piece(color, position, this);
   this.flipPieces//()
 };

}
// int[][] myArr = new int[8][8];






function Piece(color, position, board){
  this.color = color;
  this.position = position;
  this.board = board;

  this.possMoves = [];
  this.flip(color);
  this.placePiece;
}