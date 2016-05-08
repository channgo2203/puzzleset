(* 
 * find the shortest substring of str containing the strings str1 str2,...,strm in a list
 *)

open Core.Std (* use core for more efficient with long strings *)
open Printf

(* helper functions *)
let find_sub s pos sub = 
	let r = Str.regexp_string sub in
	Str.search_forward r s pos 
		
let rfind_sub s pos sub = 
	let r = Str.regexp_string sub in
	Str.search_backward r s pos 

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
	List.iter lstr_opt ~f: (fun s_opt -> match s_opt with | None -> printf "Invalid indices\n" | Some s -> printf "%s\n" s);
	
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
 * if there are elements in l1 smaller in length than element in l2, return them
 * otherwise, add the equal elements in l2 and return 
 * all elements in l2 have same length 
 * (a1,a2) <= (b1,b2) if a2 - a1 <= b2 - b1
 *)
let update_shortest_substr l1 l2 = 
	let a_opt = List.hd l2 in 
	match a_opt with 
	| None -> []
	| Some a -> 
		let eq = List.filter l1 (fun x -> let x1, x2 = x in let a1, a2 = a in ((x2 - x1) = (a2 - a1))) in 
		let leq = List.filter l1 (fun x -> let x1, x2 = x in let a1, a2 = a in ((x2 - x1) < (a2 - a1))) in 
		if (List.is_empty leq) then List.append l2 eq 
		else leq
 
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
 * get the left most substrings in str that is a string in the list
 * return a list of strings in the list that matches 
 * For example,
 * str =  "This Th a string a Th This"
 * lstr = ["This","Th"]
 * return = ["This","Th"]
 *)
let get_left_most str lstr = 
	try 
		List.filter lstr (fun x -> if (find_sub str 0 x) = 0 then true else false)
	with Not_found -> []
	
	
let find_leftmost str pos leftmost = 
		try 
			(find_sub str pos leftmost, String.length leftmost)
		with 
			Not_found -> (-1, String.length leftmost)

let find_lastsubstr_leftmost str lstr fi leftmost_index_len = 
	(* get the substring from fi to leftmost *)
	let leftmost_index,len = leftmost_index_len in 
		let substr_to_leftmost = String.sub str fi (leftmost_index + len - fi) in 
			rsub_lstr substr_to_leftmost lstr 

(* 
 * substr_index : a substring that containing all strings in the lstr
 * str : the string for searching 
 * lstr : list of searching strings
 * return : list of substring that containing all strings in the lstr. They are generated by looking for one of the strings in lstr from the end of 
 * substr_index in str. If it is found the find the last occurence of a substring the the matched string in str. Finally return the list of all such substring 
 * For example, 
 * str = "This Th a string a Th This"
 * lstr = ["This","Th"]
 * substr_index = (0,6)
 * return = [(0,20),(22,25)]
 *)
let get_next_substr_index str lstr substr_index = 
	(* get all left most strings *)
	let fi,li = substr_index in 
		let substr_opt = get_substring str fi li in 
			match substr_opt with
			| None -> []
			| Some substr -> 
				let lleftmost = get_left_most substr lstr in 
				let _ = print_lstr "Leftmost strings:" lleftmost in 
					(* find each string in lleftmost in str from last index of substr_index *)
					let lfound_leftmost_index_tmp = List.map lleftmost (find_leftmost str (li + 1)) in 
					let _ = print_lindex "Found leftmost indices:" lfound_leftmost_index_tmp in 
						(* filter all (-1,_) from lfound_leftmost_index_tmp *)
						let lfound_leftmost_index = List.filter lfound_leftmost_index_tmp (fun x -> let x1,x2 = x in x1 >= 0) in 
							let res_tmp = List.map lfound_leftmost_index (find_lastsubstr_leftmost str lstr fi) in 
								let res = List.map res_tmp (fun x -> let x1,x2 = x in (x1 + fi, x2 + fi)) in 
								let _ = print_lindex "Next substrings indices:" res in 
									let _ = print_lstr_index ("Next substrings of ---" ^ substr ^ "---") str res in
										res
							
 
(*
 * find the shortest substring that containing all strings in the list
 * lsubstr_index : list of candidate substrings by indices in str containing all strings in the list
 * str : the string for searching
 * lstr : list of searching strings
 * list_index : return a list of (findex,lindex) indicate the locations of shortest substrings containing all strings in the lstr
 *)
(* let find_shortest_substring_lstr_aux list_index lsubstr_index str lstr = *)

let find_shortest_substring_lstr str list_strings = 
	(* remove all empty strings in the lstr *)
	let lstr_tmp = List.filter list_strings (fun x -> not (String.is_empty x)) in 
	(* remove all duplicate strings in lstr_tmp *)
	let lstr = List.dedup ~compare:(compare) lstr_tmp in 
	if (List.is_empty lstr) then 
		[(0,-1)] (* empty string *)
	else if (String.is_empty str) then
		[(-1,-1)]
	else
		begin
			(* find the first occurrence of substring containing the strings in lstr *)
			let substr_index = sub_lstr str lstr in 
				if (substr_index = (-1,-1)) then 
					[(-1,-1)]
				else 
					begin
						let lcandidates = ref [substr_index] in 
							let lshortest_substr = ref [substr_index] in 
						(* loop until there is no substring candicates *)
						while (not (List.is_empty !lcandidates)) do
							begin
							  (* new list of substring candidates *)
								lcandidates := List.fold_left (List.map !lcandidates (fun x -> get_next_substr_index str lstr x)) ~init:[] ~f:(List.append);
								(* remove all duplicates *)
								List.dedup ~compare:(index_compare) !lcandidates;
								(* update list of shortest substrings *)
								lshortest_substr := update_shortest_substr !lcandidates !lshortest_substr
									
							end
						done;
						(* remove all duplicates before return *)
						List.dedup ~compare:(index_compare) !lshortest_substr
					end
		end
