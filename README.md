# STACKS
Steps to analyze RADseq data (with modifications for BestRAD libraries)
## First explore data quality with FASTQC 
### install FASTQC
```
sudo apt update
## updates the apt package manager (apt manager is similar to bioconductor or rcran)
``` 
then I install java (needed for FASTQC to work)
```
sudo apt install openjdk-11-jre-headless  
## tells apt to install the package/programme from a source (ex. online repository)
```
```
sudo apt install unzip 
## install unzip because it wasn't installed 
```
Download FASTQC from https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
and unzip folder:
```
unzip fastqc_v0.11.9.zip
```
The unzipped folder contains a script called fastqc that appears when you unzip. You need to first make it executable (see [here](https://raw.githubusercontent.com/s-andrews/FastQC/master/INSTALL.txt))
```
chmod 755 fastqc
## note: This way, you will ONLY be able to run fastqc inside the folder where it is installed.
## To run FASTQC from ANY location, you can make a link directly to where it is installed, for ex:
sudo ln -s ~/Downloads/FastQC/fastqc /usr/local/bin/fastqc
```
Now, to actually run FASTQC, use :
```
fastqc head4millR2 -o Desktop/FASTQCout/
## the command is 'fastqc' then the file you want to check. The -o is optional and defines 
## where you want the output to go (this will be a zip file and an html file)
## To visualize, right-click on the html and 'view in browser' or ...
firefox head4millR1_fastqc.html 
```
Now you are done ! you can also check this tutorial for handling/interpreting FASTQC output: [tutorial](https://rtsf.natsci.msu.edu/genomics/tech-notes/fastqc-tutorial-and-faq/) 

Once the quality of reads has been checked, we can start working with STACKS
## Install STACKS
You can download a zipped folder with the programme from [here](https://catchenlab.life.illinois.edu/stacks/) and unzip the folder like this :
```
tar xfvz stacks-2.xx.tar.gz 
## Replace the xx with the specific version of STACKS you downloaded
```
Go inside the newly unzipped folder (ex. "stacks-2.60") and :
```
./configure 
##
this script is responsible for getting ready to build STACKS in your specific system. It ensures that all dependencies that you need for the rest of the build/install process are available.
```
Now build and finish installing STACKS software with these commands:
```
make
make install (or sudo make install)
##
Find a simple explanation of what these commands do here: https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install
If you run into problems when installing, this note might help (insert the note of issues I found)
```
To check whether stacks was succesfully installed, you can type one of its commands using the 'help' flag. If help is displayed, you succeeded!
```
process_radtags -h 
```
## END of installation.

Given that data comes from Rapture protocol (citation), before running Stacks, we need to run a script to get the reads ready **** (insert here and try --bestrad command)

## Run the pipeline starting by demultiplexing the samples 
This means using the barcodes to separate the reads into the sample/Individual they originated from. The command we will use is [process_radtags](https://catchenlab.life.illinois.edu/stacks/comp/process_radtags.php) **** insert info on output of paired end reads****:
```
process_radtags -1 ./onemillreads/flipR1.fastq -2 ./onemillreads/flipR2.fastq -o  ./onemillreads/demultiplexed -b ./onemillreads/barcodes.txt -e sbfI -r -c -q
```
## Start identifying putative loci using ustacks. 
The command [ustacks](https://catchenlab.life.illinois.edu/stacks/comp/ustacks.phpwill) will take reads from individual samples and align them into matching stacks to ultimately discover putative loci. The command below will take the output of process_radtags (demultiplexed samples) and process just one sample at a time. In order to process multiple samples, you can run loops as [here](https://catchenlab.life.illinois.edu/stacks/manual/#pipe) or use this script (run_ustacks.sh) :
```
ustacks -f ./onemillreads/process_radtags.out/test_GTACGCAA.1.fq.gz  -o ./ustacks.out -i1 
```
## Build a 'catalog' of the loci present in the samples (i.e. the 'population')
This is accomplished through the [cstacks](https://catchenlab.life.illinois.edu/stacks/comp/cstacks.php) command. In order to run it, you first need to make a [population map](https://catchenlab.life.illinois.edu/stacks/manual/#popmap) which is a file with sample IDs and the population they belong to. Once you have this, just follow this command:
```
cstacks -P ~/Desktop/STACKS/onemillreads/ustacks.out/ -M  ~/Desktop/STACKS/onemillreads/popmap/pops -n 4 -p 4
##
When you define the PATH to the population map file, you need to INCLUDE the name of the file in it. In this case, the file's name is "pops"
```
## Match the samples in the population map against the newly created catalog
In this step all samples in the population would be matched against the catalog using sstacks
```
sstacks -P ~/Desktop/STACKS/onemillreads/ustacks.out/ -M ~/Desktop/STACKS/onemillreads/popmap/pops -p 4
##
-P = path to the directory containing Stacks files.
-M = path to the population map file from which to take sample names
*Remember to note whether the command requires a path to a DIRECTORY or to a FILE. In the latter case, you need to state the NAME of the file.
```
## Transpose data so that it's oriented by locus
The command below will transpose the data to orient it by locus (instead of by sample). If you have paired-end reads, this will incorporate them to the (single-end)loci that were assembled de novo *
```
tsv2bam -P ~/Desktop/STACKS/onemillreads/ustacks.out.2/ -M ~/Desktop/STACKS/onemillreads/popmap/pops2 -R  ~/Desktop/STACKS/onemillreads/samples/ -t 4
##
The -R option is only used when working with paired-end reads, to specify the directory where they are. 
```
* When working with tsv2bam and paired-end reads, you might run into an error message: "Error: Unable to find the first paired-end reads file at '/home/../sample_XXXX".
This might happen because of numerical [identifiers](https://groups.google.com/g/stacks-users/c/x0DvGQvic2A) that are added to the files as they are generated by the stacks pipeline. One solution is to use [sed](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjGpLeBiJf3AhVoJkQIHe0YCVEQFnoECAUQAQ&url=https%3A%2F%2Fwww.geeksforgeeks.org%2Fsed-command-in-linux-unix-with-examples%2F&usg=AOvVaw2EfzMYCxuDqqRmVGQLGHV8) to remove the unwanted identifiers.
## Examine a RAD data set one locus at a time, looking at all individuals in the metapopulation for that locus. 
The following command will identify SNPs within the meta population for each locus and genotype each individual for each identified SNP (The process differs depending on whether you assemble de novo or have a reference).
```
gstacks -P ~/Desktop/STACKS/onemillreads/ustacks.out.2/ -M ~/Desktop/STACKS/onemillreads/popmap/pops2 -t4
```
This will output two files: catalog.fa.gz (consensus sequence for each assembled locus) and catalog.calls (contains genotyping data). These will be used in the last part of the stacks pipeline. 
