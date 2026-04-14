#!/bin/bash
#SBATCH -A uppmax2026-1-94
#SBATCH -J phi_bt2
#SBATCH -t 00:15:00
#SBATCH -c 1

echo USER = $USER
echo QOS = $SLURM_JOB_QOS
cat $0

module load Bowtie2

INPUT_DIR=/proj/uppmax2026-1-94/ngs/phi
REF=/sw/data/igenomes/PhiX/Illumina/RTA/Sequence/Bowtie2Index/genome
OUT_DIR=/home/yuch3531/big_data/results

mkdir -p $OUT_DIR

for fq in ${INPUT_DIR}/phi_*.fq
do
    base=$(basename ${fq} .fq)
    echo "======================================"
    echo "Processing file: ${fq}"
    echo "Output file: ${OUT_DIR}/${base}.sam"

    bowtie2 \
        -x ${REF} \
        -U ${fq} \
        -S ${OUT_DIR}/${base}.sam

    echo "Finished: ${fq}"
done
