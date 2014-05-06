var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var askLessThan = function (el1, el2, callback) {
  var questionString = "Is " + el1 + " < " + el2 + " ? (y/n)";
  reader.question(questionString, function(userResponse){
    switch(userResponse){
      case "y":
        callback(true);
        break;
      case "n":
        callback(false);
        break;
      default:
        console.log("invalid response, try again: \n");
        askLessThan(el1, el2, callback);
        break;
    };
  });
};

var performSortPass = function (arr, i, madeAnySwaps, callback) {

  if (i < arr.length - 1){
    askLessThan(arr[i], arr[i + 1], function(lessThan){
      if (!lessThan) {
        var temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;

        madeAnySwaps = true;
      }

      performSortPass(arr, i + 1, madeAnySwaps, callback);
    })
  };

  if (i === arr.length - 1){
    callback(madeAnySwaps);
  };
};

var crazyBubbleSort = function(arr, sortCompletionCallback){

  var sortPassCallback = function(madeAnySwaps) {
    if (madeAnySwaps === true) {
      performSortPass(arr, 0, false, sortPassCallback);
    } else {
      sortCompletionCallback(arr);
    };
  };

  sortPassCallback(true);

};

crazyBubbleSort([3,2,1], function(arr) {console.log(arr) });
