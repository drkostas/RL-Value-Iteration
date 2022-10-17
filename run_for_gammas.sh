#!/bin/bash

# This script is used to run experiment.py for different configurations
# and save the times for each of them in a file.
# Exammple usage: ./run_for_gammas.sh 0.999 0.9 0.8 0.7 0.6 0.5

# The script takes any number of arguments that represent different gammas values
# for the experiment.py script.
# set the python executable
PYTHON=/Users/gkos/anaconda3/envs/rl_proj1/bin/python  # Replace with your python executable
# Load the arguments
gamma_values=("$@")
# Clear the file
times_file="outputs/gamma_times.txt"
rm $times_file; touch $times_file
# Loop over the gamma values
for gamma in "${gamma_values[@]}"; do
    # Run the experiment.py script for the current gamma value
    # and suppress the output
    $PYTHON experiment.py 2 4 0.5 -100 $gamma 500 40 0.01 > /dev/null;
    # read outputs/info.pkl and save the time in a file
    rt=$(python -c "import pickle;time=pickle.load(open('outputs/info.pkl', 'rb'))['time'];print(time);");
    iters=$(python -c "import pickle;iterations=pickle.load(open('outputs/info.pkl', 'rb'))['iterations'];print(iterations);");
    echo "$gamma $rt $iters $V0" >> $times_file;
    echo "Run for gamma = $gamma and got time = $rt";

done