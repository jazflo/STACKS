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
### END
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

