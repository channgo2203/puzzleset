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
record the lenght of it, sub_len
- Move forward from the last index of sub to the end of the string str, if one of 
str1, str2, or str3 occurrs and matches with the leftmost substring in sub. Then add 
the occurent substring and extra characters from the right most sub. And remove 
the occurent substring and all other extra characters after left most matched substring. 
After adding and removing characters, get the length of this new substring and compare with 
sub_len and update min_len.

- Return sub_len  
