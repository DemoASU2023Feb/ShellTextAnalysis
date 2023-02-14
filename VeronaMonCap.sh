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
# Count number of lines with Verona
grep -i verona RomeoAndJuliet.txt | wc -l > verona.txt
verona=$(cut -f 1 verona.txt)
# Count number of lines with Montague
grep -i montague RomeoAndJuliet.txt | wc -l > montague.txt
montague=$(cut -f 1 montague.txt)

# Count number of lines with Capulet
grep -i capulet RomeoAndJuliet.txt | wc -l > capulet.txt
capulet=$(cut -f 1 capulet.txt)

# Plot occcurences of each
verona_freq=$(( (100 * verona) / ( verona+ montague + capulet)))
montague_freq=$(( (100 * montague) / ( montague + verona + capulet)))
capulet_freq=$(( (100 * capulet) / ( montague + verona+ capulet)))
touch RomeAndJuliet.chart.txt
echo "A bar chart of relative frequencies of mentions" > VerMonCap.chart.txt
echo "of Verona, Montague and Capulet, from the Shakespeare play" >> VerMonCap.chart.txt
echo "" >> VerMonCap.chart.txt
echo -n "Verona   " >> VerMonCap.chart.txt
# Taken from
# https://stackoverflow.com/questions/17181787/how-to-use-variables-in-a-bash-for-loop#17181832
for i in $( eval echo {0..$verona_freq}); do
	echo -n "#" >> VerMonCap.chart.txt
done
echo "" >> VerMonCap.chart.txt
echo -n "Montague   " >> VerMonCap.chart.txt
for i in $( eval echo {1..$montague_freq}); do
	echo -n "#" >> VerMonCap.chart.txt
done
echo "" >> VerMonCap.chart.txt

echo -n "Capulet   " >> VerMonCap.chart.txt
for i in $( eval echo {1..$capulet_freq}); do
        echo -n "#" >> VerMonCap.chart.txt
done
echo "" >> VerMonCap.chart.txt

# Show output
cat VerMonCap.chart.txt



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
