require 'debugger'

def bsearch(arr, tar)
  return nil if arr.length == 0

  mid_idx = arr.length/2
    case (arr[mid_idx] <=> tar)
    when 1
       sub_arr = arr[0...mid_idx]
       bsearch(sub_arr, tar)

    when 0
      return mid_idx

    when -1
      sub_arr = arr[mid_idx + 1 ... arr.length]
      bs = bsearch(sub_arr, tar)
      return nil if bs.nil?
      (mid_idx + 1) + bs
    end



end
