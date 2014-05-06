Array.prototype.bubbleSort = function(){
  var sorted = false;

  while(!sorted) {
    sorted = true;
    for(var index = 0; index < this.length - 1; index++) {

      if(this[index] > this[index + 1]) {
        var holder = this[index];
        this[index] = this[index + 1];
        this[index + 1] = holder;

        sorted = false;
      }
    }
  }

  return this;
}

String.prototype.substrings = function(){
  var substrArr = [];

  for(var i = 0; i < this.length; i++){
    for(var j = i; j < this.length; j++){
      substrArr.push(this.slice(i, (j+1)));
    }
  }

  return substrArr;
}