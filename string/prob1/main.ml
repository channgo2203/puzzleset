(* Find the shortest substring in a string str that contains 3 other 
   strings str1, str2, and str2 
 *)

open Batteries
open Printf 

(* find the first substring containing str1, str2, and str3 
 * return first and last indices 
 *)
let find_3subs s sub1 sub2 sub3 = 
  try 
  	let index1 = BatString.find s sub1 in 
    	let index2 = BatString.find s sub2 in 
    		let index3 = BatString.find s sub3 in 
    			let findex = BatInt.min (BatInt.min index1 index2) index3 in
    				let lindex = BatInt.max (BatInt.max (index1 + BatString.length sub1) 
    							(index2 + BatString.length sub2)) 
    							(index3 + BatString.length sub3) in
      				(findex,lindex - 1)
  with Not_found -> (-1,-1)

(* find the last substring containing str1, str2, and str3 
 * return first and last indices 
 *)
let rfind_3subs s sub1 sub2 sub3 = 
	try
		let index1 = BatString.rfind s sub1 in 
			let index2 = BatString.rfind s sub2 in
				let index3 = BatString.rfind s sub3 in
					let findex = BatInt.min (BatInt.min index1 index2) index3 in
    				let lindex = BatInt.max (BatInt.max (index1 + BatString.length sub1) 
    							(index2 + BatString.length sub2)) 
    							(index3 + BatString.length sub3) in
      				(findex,lindex - 1)
  with Not_found -> (-1,-1) 

(* get the substring given first and last indices
 *)
let get_3subs s findex lindex = 
	try 
		let sub = BatString.sub s findex (lindex - findex + 1) in
			Some sub
	with Invalid_argument e -> None

(* get the left most substring that is either str1, str2, or str3 
 * from the matched substring 
 *)
let get_left_most sub str1 str2 str3 = 
	try 
		if (BatString.find sub str1) = 0 then
			str1
		else if (BatString.find sub str2) = 0 then
			str2
		else str3
	with Not_found -> ""

(* find the left most substring that is either str1, str2, or str3 
 * from the given index 
 *)
let find_left_most str pos leftmost = 
	try 
		BatString.find_from str pos leftmost
	with Not_found -> -1
			
(* scan over the string str from the first occurrent substring 
 * to find the shortest one
 *)
let rec find_min_3subs findex lindex str str1 str2 str3 = 
	let sub = get_3subs str findex lindex in
		match sub with
		| None -> (-1,-1)
		| Some s -> 
			begin
				let _ = printf "substring: (%s,%i)\n" s (BatString.length s) in 
				let leftmost = get_left_most s str1 str2 str3 in
					let _ = printf "leftmost: (%s,%i)\n" leftmost (BatString.length leftmost) in 
					let leftmost_index = find_left_most str (lindex + 1) leftmost in 
					let _ = printf "leftmost_index: %i\n" leftmost_index in 
						if (leftmost_index <> -1) then
								let _ = printf "str: (%s,%i)\n" str (BatString.length str) in
								let _ = printf "sub_leftmost_lindex: (%i,%i)\n" findex (leftmost_index + BatString.length leftmost) in
								let sub_leftmost = BatString.sub str findex (leftmost_index + BatString.length leftmost) in
									let _ = printf "sub_leftmost: (%s,%i)\n" sub_leftmost (BatString.length sub_leftmost) in 
									let new_findex, new_lindex = rfind_3subs sub_leftmost str1 str2 str3 in
										let _ = printf "sub_index: (%i,%i)\n" new_findex new_lindex in 
											find_min_3subs new_findex new_lindex str str1 str2 str3
						else
							let _ = printf "sub_index: (%i,%i)\n" findex lindex in 
								(findex,lindex)
			end

(* usage message *)
let usage_msg = "Usage: find_3subs str str1 str2 str3\n"
	
(* entry point *)
let _ = 
	if (Array.length Sys.argv) < 5 then
		printf "%s\n" usage_msg
	else
		let str = Sys.argv.(1) in 
			let str1 = Sys.argv.(2) in
				let str2 = Sys.argv.(3) in
					let str3 = Sys.argv.(4) in
						let first_findex, first_lindex = find_3subs str str1 str2 str3 in
							let findex, lindex = find_min_3subs first_findex first_lindex str str1 str2 str3 in 
								printf "sub_index: (%i,%i)\n" findex lindex
									
							
(* A test data 
 * str = "this is dummy dummy a dummy is this string this a other string"
 * str1 = "a"
 * str2 = "this"
 * str3 = "is" 
 *)
