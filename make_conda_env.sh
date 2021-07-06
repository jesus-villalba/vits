#!/bin/bash

conda create --prefix $PWD/env
conda activate $PWD/env
conda install pytorch==1.6.0 torchvision==0.7.0 -c pytorch
conda install pip
pip install requirements.txt
