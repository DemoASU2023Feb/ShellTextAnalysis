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
#
# Get the book from Gutenburg
curl https://gutenberg.org/cache/epub/1513/pg1513.txt > RomeoAndJuliet.txt
#
# Count number of lines with Verona
grep -i Verona RomeoAndJuliet.txt | wc -l > Verona.txt
Verona=$(cut -f 1 Verona.txt)
#
# Count number of lines with Capulet
grep -i Capulet RomeoAndJuliet.txt | wc -l > Capulet.txt
Capulet=$(cut -f 1 Capulet.txt)
#
# Count number of lines with Montague
grep -i Montague RomeoAndJuliet.txt | wc -l > Montague.txt
Montague=$(cut -f 1 Montague.txt)
#
# Plot occcurences of each
Verona_freq=$(( (100 * Verona) / ( Capulet + Verona + Montague)))
Capulet_freq=$(( (100 * Capulet) / ( Capulet + Verona + Montague)))
Montague_freq=$(( (100 * Montague) / ( Capulet + Verona + Montague)))
touch RomeoAndJulietFamilies.chart.txt
echo "A bar chart of relative frequencies of mentions" > RomeoAndJulietFamilies.chart.txt
echo "of families, from the Shakespeare play" >> RomeoAndJulietFamilies.chart.txt
#
# Taken from
# https://stackoverflow.com/questions/17181787/how-to-use-variables-in-a-bash-for-loop#17181832
#
echo "" >> RomeoAndJulietFamilies.chart.txt
echo -n "Verona   " >> RomeoAndJulietFamilies.chart.txt
for i in $( eval echo {1..$Verona_freq}); do
	echo -n "#" >> RomeoAndJulietFamilies.chart.txt
done
#
echo "" >> RomeoAndJulietFamilies.chart.txt
echo -n "Capulet   " >> RomeoAndJulietFamilies.chart.txt
for i in $( eval echo {1..$Capulet_freq}); do
	echo -n "#" >> RomeoAndJulietFamilies.chart.txt
done
#
echo "" >> RomeoAndJulietFamilies.chart.txt
echo -n "Montague  " >> RomeoAndJulietFamilies.chart.txt
for i in $( eval echo {0..$Montague_freq}); do
	echo -n "#" >> RomeoAndJulietFamilies.chart.txt
done
#
echo "" >> RomeoAndJulietFamilies.chart.txt
#
# Show output
cat RomeoAndJulietFamilies.chart.txt
#
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




