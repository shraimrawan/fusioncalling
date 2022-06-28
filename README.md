# fusioncalling
Fusion calling using Arriba and Star Fusion 
Steps for running pipeline

Star Fusion 
conda env rnafusion2
1. Create text files with the file name, fastq read 1 and fastq read 2
2. Use star fusion /home/shraimr/miniconda3/envs/rnafusion2/lib/STAR-Fusion-v1.10.0/STAR-Fusion
  a. use library - /mnt/isilon/tasian_lab/DS-ALL_TCF3-HLF_RNAseq_30-445215256/rnaseq_analysis/CTAT_GENOME/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir/ 
  
3. /home/shraimr/miniconda3/envs/rnafusion2/lib/STAR-Fusion-v1.10.0/STAR-Fusion --genome_lib_dir /mnt/isilon/tasian_lab/DS-ALL_TCF3-HLF_RNAseq_30-445215256/rnaseq_analysis/CTAT_GENOME/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir/ \
            --left_fq $read1 \
            --right_fq $read2 \
            --CPU 6 \
            --output_dir $output file 
4. Filter fusion calls 
  a. FFPM >= 1 
  b. Take out any annotations identified in GTEx 

Arriba 
conda env arriba.v2
1. Create text file with prefix, fastq #1, fastq #, fusion.tsv, discarded.fusion.tsv
2. Use STAR to align and same references as STAR fusion above 
3. Filter fusion calls 
  a. reading frame - take out, out-of-frame and "." 
  b. confidence - high and can consider medium 
  
Arriba will have more fusion calls than Star Fusion. 




