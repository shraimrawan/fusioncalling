#! /bin/bash
#$ -cwd

#SBATCH -c 8
#SBATCH -t 90:00:00
#SBATCH --mem=60GB 
#SBATCH -a 1-13

samplesheet="/mnt/isilon/tasian_lab/JAK2_chronic_rux_resistance/JAK2_rux_project/JAK2_RNAseq/analysis/arriba.pdx/arriba.files.txt"


read1_gz=`sed -n "$SLURM_ARRAY_TASK_ID"p $samplesheet | awk '{print $2}'` 

read2_gz=`sed -n "$SLURM_ARRAY_TASK_ID"p $samplesheet | awk '{print $3}'` 

prefix=`sed -n "$SLURM_ARRAY_TASK_ID"p $samplesheet | awk '{print $1}'` 

output1=`sed -n "$SLURM_ARRAY_TASK_ID"p $samplesheet | awk '{print $4}'` 

output2=`sed -n "$SLURM_ARRAY_TASK_ID"p $samplesheet | awk '{print $5}'` 

STAR \
    --runThreadN 8 \
    --genomeDir /mnt/isilon/tasian_lab/DS-ALL_TCF3-HLF_RNAseq_30-445215256/rnaseq_analysis/CTAT_GENOME/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir/ref_genome.fa.star.idx --genomeLoad NoSharedMemory \
    --readFilesCommand zcat --readFilesIn $read1_gz $read2_gz --outFileNamePrefix $prefix \
    --outStd BAM_Unsorted --outSAMtype BAM Unsorted --outSAMunmapped Within --outBAMcompression 0 \
    --outFilterMultimapNmax 50 --peOverlapNbasesMin 10 --alignSplicedMateMapLminOverLmate 0.5 --alignSJstitchMismatchNmax 5 -1 5 5 \
    --chimSegmentMin 10 --chimOutType WithinBAM HardClip --chimJunctionOverhangMin 10 --chimScoreDropMax 30 \
    --chimScoreJunctionNonGTAG 0 --chimScoreSeparation 1 --chimSegmentReadGapMax 3 --chimMultimapNmax 50 |
    
arriba -x /dev/stdin \
       -g /mnt/isilon/tasian_lab/DS-ALL_TCF3-HLF_RNAseq_30-445215256/rnaseq_analysis/CTAT_GENOME/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir/ref_annot.gtf -a /mnt/isilon/tasian_lab/DS-ALL_TCF3-HLF_RNAseq_30-445215256/rnaseq_analysis/CTAT_GENOME/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir/ref_genome.fa \
       -f blacklist,known_fusions -o $output1 -O $output2

