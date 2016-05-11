(* 
 * find the shortest substring of str containing the strings str1 str2,...,strm in a list
 *)

(* use core for more efficient with long strings *)
open Core.Std 
open Printf

(* 
 * find substring sub in string str forward from pos 
 *)
let find_sub str pos sub = 
	let r = Str.regexp_string sub in
	Str.search_forward r str pos 

(* 
 * find substring sub in string str backward from pos 
 *)
let rfind_sub str pos sub = 
	let r = Str.regexp_string sub in
	Str.search_backward r str pos 

(*
 * get the substring from findex to lindex inclding characters at findex and lindex
 *)
let get_substring str findex lindex = 
	try 
		let sub = String.sub str findex (lindex - findex + 1) in
		Some sub
	with 
		Invalid_argument e -> None

(*
 * min element in a list
 *)
let min_element l = 
	let h = List.hd l in
	match h with
	| None -> -1
	| Some i -> List.fold_left l ~init:i ~f:(fun a b -> if a <= b then a else b)

(*
 * max element in a list
 *)
let max_element l = 
	let h = List.hd l in 
	match h with 
	| None -> -1
	| Some i -> List.fold_left l ~init:i ~f:(fun a b -> if a >= b then a else b)

(* print all strings in the list of indices *)
let print_lstr_index des str lindex = 
	printf "-------------------------------\n";
	printf "%s\n" des;
	
	let lstr_opt = 
	List.map lindex 
		(fun x -> 
			let fi,li = x in 
				get_substring str fi li) 
	in 
	List.iter lstr_opt ~f: (fun s_opt -> 
		match s_opt with 
		| None -> printf "Invalid indices\n" 
		| Some s -> printf "%s\n" s);
	
	printf "-------------------------------\n"

(* print all strings in a list *)
let print_lstr des lstr = 
	printf "-------------------------------\n";
	printf "%s\n" des;
	
	List.iter lstr ~f: (fun s -> printf "%s\n" s);
	
	printf "-------------------------------\n"

(* print a list of indices *)
let print_lindex des lindex = 
	printf "-------------------------------\n";
	printf "%s\n" des;
	
	List.iter lindex ~f: (fun s -> let x,y = s in printf "(%i,%i)\n" x y);
	
	printf "-------------------------------\n"
	
(*
 * compare two pair of indices 
 *)
let index_compare x y = 
	let x1, x2 = x in 
	let y1, y2 = y in
	if (x1 = y1 && x2 = y2) then 0 
	else if ((x1 < y1) || (x1 = y1 && x2 <= y2)) then -1 
	else 1
 
(*
 * update the set shortest substrings
 * if new_sub is not longer, then add it to the set
 *)
let update_lshortest_substr l i = 
	let a_opt = List.hd l in
	match a_opt with
	| None -> [ i ]
	| Some a -> 
		let i1, i2 = i in 
		let a1, a2 = a in 
		if ((i2 - i1) = (a2 - a1)) then
			i :: l
		else if ((i2 - i1) < (a2 - a1)) then 
			[ i ]
		else l

(* 
 * find the first occurence of a substring in str that contains all strings in lstr
 * return the first and list indices of that substring
 * For example,
 * str = "This is a This string"
 * lstr = ["This"; "a"]
 * return = (0, 8)
 *)
let sub_lstr str lstr = 
	try 
		let length_list = List.map lstr (String.length) in 
		(* list of first occurence indices of all strings in lstr *)
		let findex_list = List.map lstr (find_sub str 0) in 
		(* return the first occurence of substring containing all strings in lstr *)
		let lindex_list = List.map2_exn findex_list length_list (+) in 
		((min_element findex_list), ((max_element lindex_list) - 1))					
	with 
		| Invalid_argument e -> (-1, -1)
		| Not_found -> (-1, -1)

(* 
 * find the last occurence of a substring in str that contains all strings in lstr
 * return the first and list indices of that substring
 * For example,
 * str = "This is a This string"
 * lstr = ["This"; "a"]
 * return = (8, 13)
 *)
let rsub_lstr str lstr = 
	try 
		let length_list = List.map lstr (String.length) in 
		(* list of first occurence indices of all strings in lstr *)
		let findex_list = List.map lstr (rfind_sub str (String.length str - 1)) in 
		(* return the last occurence of substring containing all strings in lstr *)
		let lindex_list = List.map2_exn findex_list length_list (+) in 
		((min_element findex_list), ((max_element lindex_list) - 1))					
	with 
		| Invalid_argument e -> (-1, -1)
		| Not_found -> (-1, -1)


(*
 * find the shortest substring that containing all strings in the list
 * str : the string for searching
 * lstr : list of searching strings
 * n : the number of substrings containing all strings in lstr
 * lshortest_substr : return a list of (findex,lindex) indicate the locations of shortest substrings containing all strings in the lstr
 *)
let rec find_shortest_substrings_aux n lshortest_substr str lstr offset = 
	if (String.is_empty str) then
		(n, lshortest_substr)
	else
		begin
			(* find forward a substring containing the strings in lstr *)
			let substr_index = sub_lstr str lstr in 
			if (substr_index = (-1, -1)) then 
				(* not found, find in string without the first character *)
				find_shortest_substrings_aux n lshortest_substr (String.sub str 1 (String.length str - 1)) lstr (offset + 1)
			else 
				(* find in string without the first character with updated lshortest_substr *)
				let fi, li = substr_index in 
				find_shortest_substrings_aux (n + 1) (update_lshortest_substr lshortest_substr (fi + offset, li + offset)) (String.sub str 1 (String.length str - 1)) lstr (offset + 1)
		end

let find_shortest_substrings str list_strings = 
	(* remove all empty strings in the lstr *)
	let lstr_tmp = List.filter list_strings (fun x -> not (String.is_empty x)) in 
	(* remove all duplicate strings in lstr_tmp *)
	let lstr = List.dedup ~compare:(compare) lstr_tmp in 
	if (List.is_empty lstr) then 
		(-1, [(0,-1)]) (* empty string *)
	else if (String.is_empty str) then
		(0, [(-1,-1)])
	else
		begin
			(* find the first occurrence of substring containing the strings in lstr *)
			let substr_index = sub_lstr str lstr in 
				if (substr_index = (-1,-1)) then 
					(0, [(-1,-1)])
				else 
					begin
						let (n, lshortest_substr) = find_shortest_substrings_aux 1 [substr_index] (String.sub str 1 (String.length str - 1)) lstr 1 in 
						(* remove all duplicates before return *)
						(n, List.dedup ~compare:(index_compare) lshortest_substr)
					end
		end		
