Find a shortest substring contains the given strings

Problem: Given a string str and a list of strings lstr. 
Find a shortest substring of str that contains all strings in lstr.

1. Simple solution

- Generate all substrings of str
- For each substring, check that it contains all strings in lstr
- Print out the smallest one

Complexity: depend on the number of substrings which is O(n^2), where n is the length of 
str (since the number of substring with the length m is (n - m) + 1), then if finding each 
substring is O(n), the complexity is O(n^3)


2. Efficient solution

- Find the first occurence of a substring of str containing all strings in lstr
- If there exists one, store its length. Then create a new string from str by removing 
the first character, called str1. If it is empty, return. Otherwise find the first 
occurence of a substring of str1.

The complexity is O(n^2) where n is the length of str