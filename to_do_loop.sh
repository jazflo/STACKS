## we store a string in the variable called "files"
## Never put space between the = and variable.
files="sample_01
sample_02
sample_03"
## to call a variable content we add the prefix $
echo $files
for file in $files
do
 echo $file
done