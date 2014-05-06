// recursive range
// recursive sum
// recursive exp
// recursive fibonacci
// recursive bin search
// recursive make change
// recursive merge_sort
// recursive subsets

function range(start, end){

  return (start === end) ? [start] : range(start, end - 1).concat([end]);

}

function sum(arr){

  return (arr.length === 1) ? arr[0] : sum(arr.slice(1, arr.length)) + arr[0];

}

function exp1(base, power){

  return (power === 1) ? base : base * exp1(base, power - 1);

}

function exp2(base, power){

  if(power === 1) return base;

  if(power % 2 === 0){
    result = exp2(base, power/2);
    return result * result; //
  } else {
    result = exp2(base, (power - 1)/2);
    return base * result * result;
  }

}

function fibonacci(count){

 if (count === 0) return [1];
 if (count === 1) return [1, 1];

 nextFibArr = fibonacci(count - 1);
 sumOfLastTwo = nextFibArr[nextFibArr.length-1] + nextFibArr[nextFibArr.length-2];
 return nextFibArr.concat([sumOfLastTwo]);

}

function binarySearch(arr, target){
  if (arr.length === 0) return NaN;

  midpoint = Math.floor(arr.length/2);
  if (arr[midpoint] === target) {
    return midpoint;
  } else if (arr[midpoint] > target) {
    return binarySearch(arr.slice(0, midpoint), target);
  } else {
    return midpoint + 1 + binarySearch(arr.slice(midpoint+1, arr.length), target);
  }

}

function makeChange(change, coins){
  var masterChangeSize = Number.POSITIVE_INFINITY;
  var masterChange;

  // for each recursive round, use an iterative loop to consider each of the
  // candidate least-coin change permutations, and return only the winner

  if(change === 0 || change < coins[coins.length - 1]) return new Array();
  // if(change < coins[coins.length - 1]) return NaN;


  for(var i = 0; i < coins.length; i++){
    if (coins[i] <= change){
      storedExample = makeChange(change - coins[i], coins).concat([coins[i]]);
      if(storedExample.length < masterChangeSize){
        masterChange = storedExample;
        masterChangeSize = storedExample.length;
      }
    }
  }

  return masterChange;
}

function mergeSort(arr){

  if(arr.length === 0) return new Array();
  if(arr.length === 1) return arr;

  var midpoint = Math.floor(arr.length/2);
  var half1 = arr.slice(0, midpoint);
  var half2 = arr.slice(midpoint, arr.length);

  function merge(arr1, arr2){
    mergedArr = [];

    while(arr1.length !== 0 && arr2.length !== 0){
      mergedArr.push(
        (arr1[0] <= arr2[0]) ? arr1.shift() : arr2.shift()
      );
    }

    return mergedArr.concat(arr1).concat(arr2);
  }

  return merge(mergeSort(half1), mergeSort(half2));
}

function subsets(arr){
  if (arr.length === 0) return new Array([]);

  var next_subs = subsets(arr.slice(1, arr.length));
  var removed_elem = arr[0];
  var removed_arr = [removed_elem];
  var mod_next_subs = next_subs.map(function(subset){
    return subset.concat([removed_elem]);
  });

  return next_subs.concat(mod_next_subs);
}


