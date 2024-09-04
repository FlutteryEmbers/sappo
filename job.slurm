#!/bin/bash

##NECESSARY JOB SPECIFICATIONS
#SBATCH --job-name=sappo       #Set the job name to "JobExample1"
#SBATCH --time=24:00:00              #Set the wall clock limit to 1hr and 30min
#SBATCH --ntasks=1                   #Request 1 task
#SBATCH --mem=2560MB                  #Request 2560MB (2.5GB) per node
#SBATCH --output=std_out/sappo.%j      #Send stdout/err to "Example1Out.[jobID]"

##OPTIONAL JOB SPECIFICATIONS
##SBATCH --mail-type=ALL              #Send email on all job events
##SBATCH --mail-user=shiliwu@tamu.edu    #Send all emails to email_address

module load WebProxy
export http_proxy=http://10.73.132.63:8080
export https_proxy=http://10.73.132.63:8080

module load Anaconda3                # Load Anaconda module or other required modules
conda init bash
source ~/.bashrc
conda activate sappo                 # Activate your conda environment

python algo_envs/adversarial_attack_rs.py --env_name=Hopper --attacker_limit=0.01 --max_version=200000
# Deactivate conda environment (optional, as it will deactivate upon job completion)
conda deactivate