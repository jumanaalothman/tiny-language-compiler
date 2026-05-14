CSC340 - Programming Project Phase-1 (Lexical Analyzer for TINY)

Student Team:
1. Sara Alrowaily 443200756
2. Dena Bintwaim 444201130
3. Jumana Alothman 443202103
4. Njoud Alzamil 444201091

Course: CSC340 - Programming Languages and Compilation
Instructor: Dr. Nourah Alangari
Due Date: October 12, 2025

------------------------------------------------------------
Files Submitted
1) tiny.l        - Lex source file implementing the TINY lexical analyzer
2) README.txt    - This documentation file
3) test.tiny     - Sample TINY program used for testing (from the assignment)

------------------------------------------------------------
How to Build and Run
(Windows via Cygwin)

1. Open Cygwin Terminal and navigate to the project folder:
   cd /cygdrive/c/Users/---/Downloads

2. Generate the C source using flex:
   /usr/bin/flex tiny.l

3. Compile:
   gcc lex.yy.c -lfl -o tiny

4. Run on the provided test file:
   ./tiny < test.tiny

Notes:
- The analyzer prints one token per line in the order they appear.
- Comments and whitespace are ignored.
- The output matches the token list from the project specification.

Environment:
- Cygwin (64-bit)
- flex 2.x
- gcc 10+

------------------------------------------------------------
Design Choices
- Reserved words are matched explicitly and are case-sensitive (lowercase only).
- Whitespace (spaces, tabs, and newlines) and comments starting with "--" are ignored.
- Identifiers follow the pattern [a-zA-Z][a-zA-Z0-9_]*.
- Numbers are matched as [0-9]+.
- Operators and symbols are handled individually.
- Any other unrecognized symbols are ignored.
- The goal was to produce clean, token-by-token output matching the provided example.

------------------------------------------------------------
Testing
- The main test program used was the provided TINY sample (test.tiny).
- The output was verified line by line against the expected tokens in the assignment.
- The analyzer correctly identifies and prints all tokens in order.
- No lexical errors were produced during valid test runs.

Expected Behavior:
- Tokens are printed one per line, matching the assignment example:
  PROGRAM, IDENT mytest, SEMICOLON, etc.

------------------------------------------------------------
Assistance / Collaboration
This project was completed collaboratively by the following team members:

1. Sara Alrowaily 443200756
2. Dena Bintwaim 444201130
3. Jumana Alothman 443202103
4. Njoud Alzamil 444201091

We collaborated on understanding the TINY specification, defining token rules,
testing the program, and verifying that the output matches the expected results.

------------------------------------------------------------
Feedback / Comments
- The project was clear and easy to follow, especially after testing it with test.tiny.txt
- We faced some small issues at first while setting up flex, but once configured, it worked correctly.
- It helped us understand how tokens are processed.
- Overall, it was a useful experience to learn the basics of lexical analysis and compiler construction.
