Find a shortest substring contains three given strings

Problem: Given a string str and three other strings str1 str2 str3.
Find a shortest substring of str that contains all str1, str2, and str3

1. Simple solution

- Generate all substrings of str
- For each substring, check that it contains str1, str2, and str3
- Print out the smallest one

Complexity: depend on the number of substrings which is O(n^2)

2. Efficient solution

- Find the first occurence of substrings containing str1, str2, and str3, called sub, 
record the lenght of it, sub_len (note, sub_len consists of the first index and the last 
index, len = last index - fist index + 1)

- (*) Find from the last index of sub to the end of str the first occurence of the left most 
substring (str1, str2 or str3)

- If there is a match, sub = sub new string from the fist index of sub to the last index 
of the matching string. Find the last occurence of substring containing str1, str2, and 
str3 in sub. Update sub = new matching substring. 

- Compare the length of this new substring with sub_len, if it is smaller then update 
sub_len. 

- Go back to (*) 

- Return sub_len  
