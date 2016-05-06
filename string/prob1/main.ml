(** Find the shortest substring in a string str that contains 3 other strings str1, str2, and str2 *)

open Batteries

let find_3subs s sub1 sub2 sub3 = 
  try let index1 = BatString.find s sub1 in 
    let index2 = BatString.find s sub2 in 
    let index3 = BatString.find s sub3 in 
    let findex = BatInt.min (BatInt.min index1 index2) index3 in
    let lindex = BatInt.max (BatInt.max (index1 + BatString.length sub1) (index2 + BatString.length sub2)) (index3 + BatString.length sub3) - 1 in
      (findex,lindex)
  with Not_found -> (-1,-1)

