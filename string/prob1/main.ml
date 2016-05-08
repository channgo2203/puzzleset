(* Find the shortest substring in a string str that contains 3 other 
   strings str1, str2, and str2 
 *)

open Printf 
open Prob1

(* usage message *)
let usage_msg = "Usage: main str str_1 str_2 ... str_n\n"
		
		
(* entry point *)
let _ = 
	if (Array.length Sys.argv) < 3 then
		printf "%s\n" usage_msg
	else 
		begin
			let str = Sys.argv.(1) in 
				let lstr = ref [] in 
					for i = 2 to (Array.length Sys.argv - 1) do
						lstr := (Sys.argv.(i))::(!lstr) 
					done;
				
					let lshortest_substr_index = find_shortest_substring_lstr str !lstr in 
						print_lindex "Shortest substrings indices:" lshortest_substr_index;
						print_lstr_index "Shortest substrings:" str lshortest_substr_index
		end
									
							
(* A test data 
 * str = "this is dummy dummy a dummy is this string this a other string"
 * str1 = "a"
 * str2 = "this"
 * str3 = "is" 
 *)
