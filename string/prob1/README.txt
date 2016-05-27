Find a Shortest Substring Contains the Given Strings

Given a string str and a list of strings lstr. Find a shortest substring of str that contains all strings in a list of strings lstr.

For example, given str = “this is a test string this a” and lstr = [“is”; “this”; “a”], then the output string is “this a”.

Simple Solution

Generate all substrings of str.

For each substring, check that it contains all strings in lstr.

Print out the smallest one.

Complexity

The complexity depends on the number of substrings which is O(n2)O(n2), where nn is the length of str (since the number of substring with the length mm is (n−m)+1)(n−m)+1). If finding each substring is O(n)O(n). Then, the complexity is O(n3).O(n).

Efficient Solution

Find the first occurence of a substring of str containing all strings in lstr.

If there exists one, called substr, then store its length as the indices of its first and last characters in str in a list.

Create a new string from str from the index of the character after the first character of substr,called str1. If it is empty, return the list. Otherwise find the first occurence of a substring of str1 that contains all strings in lstr. Compare its length with the store value in the list, if it is smaller or equal, then add the string indices in the list.

Repeat the steps above.

Complexity

The complexity is nmnm where mm is number of substrings containing all strings in lstr such that its leftmost and rightmost substrings are strings in lstr, and nn is the length of str. In the worst-case, it is O(n2) when str is string of same characters and lstr is list of this single character strings.
