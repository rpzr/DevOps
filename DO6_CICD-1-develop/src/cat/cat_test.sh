#!/bin/bash

echo -e "Hello World\n123\n\nl3�;R81'�(�+�lx���_�y�i\n-i\nCatTeStiNG!!!!!!!!!!!\n!@#^&^\nend" > test.txt

echo "Running Test 1: Simple cat"
./s21_cat test.txt > output.txt
cat test.txt > expected.txt
diff output.txt expected.txt && echo "Test 1 passed!" || echo "Test 1 failed!"

echo "Running Test 2: (-b)"
./s21_cat -b test.txt > output.txt
cat -b test.txt > expected.txt
diff output.txt expected.txt && echo "Test 2 passed!" || echo "Test 2 failed!"

echo "Running Test 2.1: (--number-nonblank)"
./s21_cat --number-nonblank test.txt > output.txt
cat --number-nonblank test.txt > expected.txt
diff output.txt expected.txt && echo "Test 2.1 passed!" || echo "Test 2.1 failed!"

echo "Running Test 3: (-n)"
./s21_cat -n test.txt > output.txt
cat -n test.txt > expected.txt
diff output.txt expected.txt && echo "Test 3 passed!" || echo "Test 3 failed!"

echo "Running Test 3.1: (--number)"
./s21_cat --number test.txt > output.txt
cat --number test.txt > expected.txt
diff output.txt expected.txt && echo "Test 3.1 passed!" || echo "Test 3.1 failed!"

echo "Running Test 4: (-s)"
./s21_cat -s test.txt > output.txt
cat -s test.txt > expected.txt
diff output.txt expected.txt && echo "Test 4 passed!" || echo "Test 4 failed!"

echo "Running Test 4.1: (--squeeze-blank)"
./s21_cat --squeeze-blank test.txt > output.txt
cat --squeeze-blank test.txt > expected.txt
diff output.txt expected.txt && echo "Test 4.1 passed!" || echo "Test 4.1 failed!"

echo "Running Test 5: (-v)"
./s21_cat -v test.txt > output.txt
cat -v test.txt > expected.txt
diff output.txt expected.txt && echo "Test 5 passed!" || echo "Test 5 failed!"

echo "Running Test 6: (-e)"
./s21_cat -e test.txt > output.txt
cat -e test.txt > expected.txt
diff output.txt expected.txt && echo "Test 6 passed!" || echo "Test 6 failed!"

echo "Running Test 7: (-t)"
./s21_cat -t test.txt > output.txt
cat -t test.txt > expected.txt
diff output.txt expected.txt && echo "Test 7 passed!" || echo "Test 7 failed!"

echo "Running Test 8: (-b -s -e)"
./s21_cat -bse test.txt > output.txt
cat -bse test.txt > expected.txt
diff output.txt expected.txt && echo "Test 8 passed!" || echo "Test 8 failed!"

rm -f test.txt test.txt test.txt output.txt expected.txt
