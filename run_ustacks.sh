## when naming vars "" stands for literal string
## we use `` to store the output of the command into a variable
mkdir log_ustacks
files=`ls ~/Desktop/STACKS/onemillreads/demultiplexed/*[ATGC].1.fq`
id=1
for file in $files
do
 ustacks -f $file -o ~/Desktop/STACKS/ustacks/ -i $id 2> log_ustacks/${id}.log
 let "id+=1"
done