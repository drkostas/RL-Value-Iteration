#!/bin/bash

# This script is used to run experiment.py for different configurations
# and save the times for each of them in a file.
# Example usage: ./run_for_thetas.sh 0.1 0.01 0.001 0.0001 0.00001 0.000001 

# set the python executable
PYTHON=/Users/gkos/anaconda3/envs/rl_proj1/bin/python  # Replace with your python executable
# Load the arguments
theta_values=("$@")
# Clear the file
times_file="outputs/theta_times.txt"
rm $times_file; touch $times_file
# Loop over the theta values
for theta in "${theta_values[@]}"; do
    # Run the experiment.py script for the current theta value
    # and suppress the output
    $PYTHON experiment.py 2 4 0.5 -100 0.9 500 40 $theta > /dev/null;
    # read outputs/info.pkl and save the time in a file
    rt=$(python -c "import pickle;time=pickle.load(open('outputs/info.pkl', 'rb'))['time'];print(time);");
    iters=$(python -c "import pickle;iterations=pickle.load(open('outputs/info.pkl', 'rb'))['iterations'];print(iterations);");
    echo "$theta $rt $iters $V0" >> $times_file;
    echo "Run for theta = $theta and got time = $rt";

done