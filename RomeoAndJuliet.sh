#!/bin/bash
#
# A script to get the text of Romeo and Juliet and
# do some analysis of it
#
# This script is available under the MIT license
# see the file LICENSE for more details
#
# References
# https://en.wikipedia.org/wiki/Romeo_and_Juliet
# https://gutenberg.org/ebooks/1513
# https://ryanstutorials.net/bash-scripting-tutorial/bash-arithmetic.php

# Get the book from Gutenburg
curl https://gutenberg.org/cache/epub/1513/pg1513.txt > RomeoAndJuliet.txt
# Count number of lines with Juliet
grep -i juliet RomeoAndJuliet.txt | wc -l > juliet.txt
juliet=$(cut -f 1 juliet.txt)
# Count number of lines with Romeo
grep -i romeo RomeoAndJuliet.txt | wc -l > romeo.txt
romeo=$(cut -f 1 romeo.txt)
# Plot occcurences of each
juliet_freq=$(( (100 * juliet) / ( romeo + juliet)))
romeo_freq=$(( (100 * romeo) / ( romeo + juliet)))
touch RomeAndJuliet.chart.txt
echo "A bar chart of relative frequencies of mentions" > RomeAndJuliet.chart.txt
echo "of Romeo and Juliet, from the Shakespeare play" >> RomeAndJuliet.chart.txt
echo "" >> RomeAndJuliet.chart.txt
echo -n "Juliet  " >> RomeAndJuliet.chart.txt
# Taken from
# https://stackoverflow.com/questions/17181787/how-to-use-variables-in-a-bash-for-loop#17181832
for i in $( eval echo {0..$juliet_freq}); do
	echo -n "#" >> RomeAndJuliet.chart.txt
done
echo "" >> RomeAndJuliet.chart.txt
echo -n "Romeo   " >> RomeAndJuliet.chart.txt
for i in $( eval echo {1..$romeo_freq}); do
	echo -n "#" >> RomeAndJuliet.chart.txt
done
echo "" >> RomeAndJuliet.chart.txt
# Show output
cat RomeAndJuliet.chart.txt

# EXERCISE
#
# a) Which house is mentioned more frequently
#    Verona, Montague or Capulet?
#
# b) Examine another book from 
#    https://www.gutenberg.org/ebooks/subject/2487
#    or another public domain book of your choice
#    in a language of your choice
#
# c) How might you use functions to simplify this
#    script?
#
# d) Stylo is an R package that makes it easier
#    to analyze texts.  After learning about R
#    try out https://www.vanderbilt.edu/digitalhumanities/using-r-for-stylometric-analysis-with-the-stylo-package/
