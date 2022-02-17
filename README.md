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
Now you are done ! you can also check this tutorial for handling/interpreting FASTQC output:
https://rtsf.natsci.msu.edu/genomics/tech-notes/fastqc-tutorial-and-faq/ 
### END