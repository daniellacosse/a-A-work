require 'debugger'

def bsearch(arr, tar)
  bsearch_aug(arr.sort, tar)
end

def bsearch_aug(arr, tar, adjuster = 0)
  #debugger

return nil if arr.length == 0

mid_idx = arr.length/2
  case (arr[mid_idx] <=> tar)
  when 1
     sub_arr = arr[0...mid_idx]
     bsearch_aug(sub_arr, tar, adjuster)

  when 0
    return mid_idx + adjuster

  when -1
    sub_arr = arr[mid_idx + 1 ... arr.length]
    bsearch_aug(sub_arr, tar, adjuster + mid_idx + 1)
  end

end
