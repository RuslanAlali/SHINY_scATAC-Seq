Preparing scATAC-Seq sample for analysis
----------------------------------------

Copy the files into Sample directory with all fastq files from single cell sequences. Put only one sample in the folder.

Make sure that bowtie2, samtools, HOMER +v4.1 are installed. Download Gene refernce from GenCode and index it with bowtie-build.

Make sure that you change folder to bowtie2 index files at line 26 (from /home/ros/Desktop/NCT_projects/Genome37.13/bt13)

Execute "prepare_sample".

