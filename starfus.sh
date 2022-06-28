#! /bin/bash
#$ -cwd

#SBATCH -c 6
#SBATCH -t 96:00:00
#SBATCH --mem=60GB 
#SBATCH -a 6

samplesheet="/mnt/isilon/tasian_lab/JAK2_chronic_rux_resistance/JAK2_rux_project/JAK2_RNAseq/analysis/starfusion.pdx/files.txt"

file=`sed -n "$SLURM_ARRAY_TASK_ID"p $samplesheet | awk '{print $1}'`

read1=`sed -n "$SLURM_ARRAY_TASK_ID"p $samplesheet | awk '{print $2}'` # read1

read2=`sed -n "$SLURM_ARRAY_TASK_ID"p $samplesheet | awk '{print $3}'` # read2

mkdir $file

wait

/home/shraimr/miniconda3/envs/rnafusion2/lib/STAR-Fusion-v1.10.0/STAR-Fusion --genome_lib_dir /mnt/isilon/tasian_lab/DS-ALL_TCF3-HLF_RNAseq_30-445215256/rnaseq_analysis/CTAT_GENOME/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir/ \
            --left_fq $read1 \
            --right_fq $read2 \
            --CPU 6 \
            --output_dir /mnt/isilon/tasian_lab/JAK2_chronic_rux_resistance/JAK2_rux_project/JAK2_RNAseq/analysis/starfusion.pdx/$file