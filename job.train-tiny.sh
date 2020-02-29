#!/bin/bash

#######################
# Slurm Configuration #
#######################

# Schedules and Resources
#SBATCH --nodes=1
##SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32GB
#SBATCH --time=24:00:00  # Default: one-hour 01:00:00

# GPU resources to request
# - Format: "gpu:{NUM_GPUS}" 
#    or "gpu:{GPU_TYPE}:{NUM_GPUS}" (if you want to specify a gpu type)
# - Avaiable GPU types: 
#    at HPC: p1080(? need-to-confirm), k80, p40, p100, v100
#    at CIMS: ...
#SBATCH --gres=gpu:v100:1

#SBATCH --job-name=yolov3-tiny # Specify the name of this job.
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=%u@nyu.edu
#SBATCH --output=%x.%j.out

echo "Puring all modules previously loaded"
module purge
echo "Loading default modules $DEFAULT_MODULES"
module load ${DEFAULT_MODULES}

# Activate a virtual environment if needed.
source $VENV_HOME/tc-1.4/bin/activate  

echo "Begin at `date`"
SECONDS=0  # to measure elapsed time for this job.

# From here you can write your own commands to run.
# e.g. 
#   python train.py

RESUME=""
if [[ -f "./weights/last.pt" ]]; then
  echo "Resume training from 'weights/last.pt'"
  RESUME="--resume"
fi

python train.py \
  --weights '' \
  --cfg yolov3-tiny.cfg \
  --data data/coco2014.data \
  --img-size 320 --epochs 273 \
  --batch 64 --accum 1 --multi-scale $RESUME


echo "Done. Elasped time: $SECONDS (sec)"
