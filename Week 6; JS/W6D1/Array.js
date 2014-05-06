//--Array--
// #Remove dups/my_uniq
// #Two_sum
// #My transpose

Array.prototype.myUniq = function() {
  var uniqArr = new Array();

  var addUniqElem = function(element, index, array){
    for(var i = 0; i < uniqArr.length; i++) {
      if (element === uniqArr[i]) return;
    }
    uniqArr.push(element);
  };

  this.forEach(addUniqElem);
  return uniqArr;
}

Array.prototype.twoSum = function(){
  var sumPairs = new Array();

  for(var i = 0; i < this.length - 1; i++){
    for(var j = (i + 1); j < this.length; j++){
      if ((this[i] + this[j]) === 0) sumPairs.push([i, j]);
    };
  };

  return sumPairs;
}

Array.prototype.myTranspose = function(){
  var transposedArray = new Array();

  for(var i = 0; i < this.length; i++){
    transposedArray.push(new Array());
    for(var j = 0; j < this.length; j++){
       transposedArray[i][j] = this[j][i];

    }
  }

  return transposedArray;
}