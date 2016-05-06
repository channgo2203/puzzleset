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
    							(index3 + BatString.length sub3) - 1 in
      (findex,lindex)
  with Not_found -> (-1,-1)

(* get the substring given first and last indices
 *)
let get_3subs s indices = 
	let (findex,lindex) = indices in
		try 
			let sub = BatString.sub s findex (lindex - findex + 1) in
				Some sub
		with Invalid_argument e -> None

(* scan over the string str from the first occurrent substring 
 * to find the shortest one
 *)
let find_min_3subs str str1 str2 str3 = 
	let fist-sub = get_3subs str (find_3subs str str1 str2 str3) in
		match first-sub with
		| None -> None
		| Some s ->
			begin
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
			let sub = find_min_3subs str str1 str2 str3 in
				match sub with
				| None -> printf "Cannot find such sub string\n"
				| Some s -> printf "(%s, %i)\n" s (BatString.length s)
				
