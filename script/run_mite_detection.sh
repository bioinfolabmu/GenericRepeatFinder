#! /bin/bash

USAGE="Usage: run_mite_detection.sh <input_genome_fasta> <output_dir> <num_threads>"

if [ "$#" -ne 3 ]; then
    echo $USAGE
	exit 1
fi

GENOME=$1
OUT_DIR=$2
NUM_THREADS=$3

grf-main -i $GENOME -o $OUT_DIR -c 1 --min_tr 10 -t $NUM_THREADS

cd-hit-est -i $OUT_DIR/candidate.fasta -o $OUT_DIR/clusteredCandidate.fasta -c 0.90 -n 5 -d 0 -T $NUM_THREADS -aL 0.99 -s 0.8 -M 0 > $OUT_DIR/cd-hit-est.out

grf-mite-cluster -i $OUT_DIR/clusteredCandidate.fasta.clstr -g $GENOME -o $OUT_DIR
