=begin

(           )
(    ) (    )
( )( ) ( )( )

def mergesort(array)

  # split the passed array in half?
#
#   return merge(arr1, arr2) if arr1.length == 1 && arr2.length == 2

base case: return array if array.length == 1

mid = array.length/2
arr1, arr2 = array[0...mid], array[mid...array.length]
merge (mergesort(arr1), mergesort(arr2))
end



# make sure that arr1 == arr1.sort and likewise for arr2
def merge(arr1, arr2)
  min = find_min(arr1.first, arr2.first)
  shift(min) from that array
  insert min into new_arr
until both are empty

end

=end

def merge_sort(array)

  return array if array.length == 1

  mid = array.length/2
  arr1, arr2 = array[0...mid], array[mid...array.length]

  merge(merge_sort(arr1), merge_sort(arr2))
end

def merge(arr1, arr2)
  merged_array = []

  until arr1.empty? || arr2.empty?
    arr1.first <= arr2.first ?
     merged_array << arr1.shift : merged_array << arr2.shift
  end

  # merged_array + arr1 + arr2
  arr2.empty? ? merged_array += arr1 : merged_array += arr2

  merged_array
end