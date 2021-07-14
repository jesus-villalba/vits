#!/bin/bash
renice 20 $$

set -eo pipefail
conda_prefix=./env/

conda_prefix="$(realpath $conda_prefix)"
if [[ -d "$conda_prefix" ]] ; then
  . /fsx/conda/miniconda3_py38_492/etc/profile.d/conda.sh
  conda deactivate
  conda activate $conda_prefix
  printf "\nINFO: activated conda environment "$conda_env" \n\n"
  if [ ! -z $python ] ; then printf "\nFAIL conflicting options python and conda_prefix. Exiting\n"; exit 1; fi
  python=$(which python)
else
  printf "\nWARNING: no conda environment activated: Make sure you have all dependencies installed\n\n"
fi

#gpu_cmd="srun -p gpu1 --constraint g4dn.2xlarge --export=ALL --exclusive"; gpus=1
#gpu_cmd="srun -p gpu1-od --constraint g4dn.2xlarge --export=ALL --exclusive"; gpus=1
#gpu_cmd="srun -p gpu4 --constraint g4dn.12xlarge --export=ALL --exclusive"; gpus=4
gpu_cmd="srun -p gpu4-od --constraint g4dn.12xlarge --export=ALL --exclusive"; gpus=4
#$gpu_cmd $python train_ms.py -c configs/vctk_base.json -m vctk_base
$gpu_cmd $python train_ms_spkemb2.py -c configs/vctk_spkemb2_b16.json -m vctk_spkemb2
