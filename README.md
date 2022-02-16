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