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
wget https://gutenberg.org/cache/epub/1513/pg1513.txt > RomeoAndJuliet.txt

# Count number of lines with Verona
grep -i Verona RomeoAndJuliet.txt | wc -l > Verona.txt
Verona=$(cut -f 1 Verona.txt)

# Count number of lines with Capulet
grep -i Capulet RomeoAndJuliet.txt | wc -l > Capulet.txt
Capulet=$(cut -f 1 Capulet.txt)

# Count number of lines with Capulet
grep -i Montague RomeoAndJuliet.txt | wc -l > Montague.txt
Montague=$(cut -f 1 Montague.txt)

# Plot occcurences of each
Verona_freq=$(( (100 * Verona) / ( Verona + Capulet + Montague)))
Capulet_freq=$(( (100 * Capulet) / ( Verona + Capulet + Montague)))
Montague_freq=$(( (100 * Montague) / ( Verona + Capulet + Montague)))

touch RomeAndJulietFamilies.chart.txt

echo "A bar chart of relative frequencies of mentions" > RomeAndJulietFamilies.chart.txt
echo "of Verona, Capulet, Montague, from the Shakespeare play" >> RomeAndJulietFamilies.chart.txt
echo "" >> RomeAndJulietFamilies.chart.txt
echo -n "Verona  " >> RomeAndJulietFamilies.chart.txt

# Taken from
# https://stackoverflow.com/questions/17181787/how-to-use-variables-in-a-bash-for-loop#17181832

for i in $( eval echo {0..$Verona_freq}); do
	echo -n "#" >> RomeAndJulietFamilies.chart.txt
done
echo "" >> RomeAndJulietFamilies.chart.txt
echo -n "Verona   " >> RomeAndJulietFamilies.chart.txt

for i in $( eval echo {1..$Capulet_freq}); do
	echo -n "#" >> RomeAndJulietFamilies.chart.txt
done
echo "" >> RomeAndJulietFamilies.chart.txt

for i in $( eval echo {1..$Montague_freq}); do
	echo -n "#" >> RomeAndJulietFamilies.chart.txt
done
echo "" >> RomeAndJulietFamilies.chart.txt

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
