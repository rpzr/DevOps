#!/bin/bash

echo -e "Hello World\nGrep Test\nAnother Line" > test1.txt
echo -e "Line One\nLine Two\nLine Three\nLine Four" > test2.txt
echo -e "Pattern match\nAnother pattern\nNo match here" > test3.txt
echo -e "Pattern one\nPattern two\nPattern three" > patterns.txt

echo "Running Test 1: Simple grep"
./s21_grep "Grep" test1.txt > output.txt
grep "Grep" test1.txt > expected.txt
diff output.txt expected.txt && echo "Test 1 passed!" || echo "Test 1 failed!"

echo "Running Test 2: (-i)"
./s21_grep -i "grep" test1.txt > output.txt
grep -i "grep" test1.txt > expected.txt
diff output.txt expected.txt && echo "Test 2 passed!" || echo "Test 2 failed!"

echo "Running Test 3: (-v)"
./s21_grep -v "Grep" test1.txt > output.txt
grep -v "Grep" test1.txt > expected.txt
diff output.txt expected.txt && echo "Test 3 passed!" || echo "Test 3 failed!"

echo "Running Test 4: (-c)"
./s21_grep -c "Line" test2.txt > output.txt
grep -c "Line" test2.txt > expected.txt
diff output.txt expected.txt && echo "Test 4 passed!" || echo "Test 4 failed!"

echo "Running Test 5: (-l)"
./s21_grep -l "Line" test1.txt test2.txt > output.txt
grep -l "Line" test1.txt test2.txt > expected.txt
diff output.txt expected.txt && echo "Test 5 passed!" || echo "Test 5 failed!"

echo "Running Test 6: (-n)"
./s21_grep -n "Line" test2.txt > output.txt
grep -n "Line" test2.txt > expected.txt
diff output.txt expected.txt && echo "Test 6 passed!" || echo "Test 6 failed!"

echo "Running Test 7: (-f)"
./s21_grep -f patterns.txt test3.txt > output.txt
grep -f patterns.txt test3.txt > expected.txt
diff output.txt expected.txt && echo "Test 7 passed!" || echo "Test 7 failed!"

echo "Running Test 8: (-e)"
./s21_grep -e "Pattern" -e "Another" test3.txt > output.txt
grep -e "Pattern" -e "Another" test3.txt > expected.txt
diff output.txt expected.txt && echo "Test 8 passed!" || echo "Test 8 failed!"

echo "Running Test 9: (-o)"
./s21_grep -o "Pattern" test3.txt > output.txt
grep -o "Pattern" test3.txt > expected.txt
diff output.txt expected.txt && echo "Test 9 passed!" || echo "Test 9 failed!"

echo "Running Test 10: (-s)"
./s21_grep -s "pattern" nonexistent.txt > output.txt
grep -s "pattern" nonexistent.txt > expected.txt
diff output.txt expected.txt && echo "Test 10 passed!" || echo "Test 10 failed!"

# Double flag

echo "Running Test 11: (-v -n)"
./s21_grep -v -n "Grep" test1.txt > output.txt
grep -v -n "Grep" test1.txt > expected.txt
diff output.txt expected.txt && echo "Test 11 passed!" || echo "Test 11 failed!"

echo "Running Test 12: (-i -c)"
./s21_grep -i -c "line" test2.txt > output.txt
grep -i -c "line" test2.txt > expected.txt
diff output.txt expected.txt && echo "Test 12 passed!" || echo "Test 12 failed!"

echo "Running Test 13: (-c -l)"
./s21_grep -c -l "Pattern" test3.txt > output.txt
grep -c -l "Pattern" test3.txt > expected.txt
diff output.txt expected.txt && echo "Test 13 passed!" || echo "Test 13 failed!"

echo "Running Test 14: (-s -n)"
./s21_grep -s -n "Line" nonexistent.txt test2.txt > output.txt
grep -s -n "Line" nonexistent.txt test2.txt > expected.txt
diff output.txt expected.txt && echo "Test 14 passed!" || echo "Test 14 failed!"

# Triple flag 

echo "Running Test 15: (-v -n -c)"
./s21_grep -v -n -c "Grep" test1.txt > output.txt
grep -v -n -c "Grep" test1.txt > expected.txt
diff output.txt expected.txt && echo "Test 15 passed!" || echo "Test 15 failed!"

echo "Running Test 16: (-i -n -o)"
./s21_grep -i -n -o "line" test2.txt > output.txt
grep -i -n -o "line" test2.txt > expected.txt
diff output.txt expected.txt && echo "Test 16 passed!" || echo "Test 16 failed!"

echo "Running Test 17: (-l -c -v)"
./s21_grep -l -c -v "Pattern" test3.txt > output.txt
grep -l -c -v "Pattern" test3.txt > expected.txt
diff output.txt expected.txt && echo "Test 17 passed!" || echo "Test 17 failed!"

echo "Running Test 18: (-s -v -c)"
./s21_grep -s -v -c "pattern" nonexistent.txt test1.txt > output.txt
grep -s -v -c "pattern" nonexistent.txt test1.txt > expected.txt
diff output.txt expected.txt && echo "Test 18 passed!" || echo "Test 18 failed!"

echo "Running Test 19: (-s -i -o)"
./s21_grep -s -i -o "line" nonexistent.txt test2.txt > output.txt
grep -s -i -o "line" nonexistent.txt test2.txt > expected.txt
diff output.txt expected.txt && echo "Test 19 passed!" || echo "Test 19 failed!"

# Clean up
rm -f test1.txt test2.txt test3.txt patterns.txt output.txt expected.txt