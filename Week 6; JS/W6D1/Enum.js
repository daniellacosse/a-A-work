function multiples(array){
  multipliedArr = [];

  for(var i = 0; i < array.length; i++){
    multipliedArr[i] = array[i] * 2;
  }
  return multipliedArr;
}

Array.prototype.myEach = function(f){

  for(var i = 0; i < this.length; i++){
    f(this[i], i, this);
  }
}

Array.prototype.myMap = function(f){
  var mappedArr = [];

  this.myEach(function(el){
    mappedArr.push(f(el));
    }
  );

  return mappedArr;
}

Array.prototype.myInject = function(f){
  var accumVal = this[0];

  this.slice(1, this.length).myEach(function(el){
      accumVal = f(accumVal, el);
    }
  );

  return accumVal;
}