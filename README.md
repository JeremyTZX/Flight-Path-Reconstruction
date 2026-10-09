# Flight Path Reconstruction

A MATLAB-based tool for reconstructing and visualizing 3D flight trajectories using smartphone sensor data. The project processes linear acceleration and atmospheric pressure measurements to estimate aircraft position and altitude, then plots the reconstructed flight path in 3D. Current testing uses data recorded during a flight's descent phase.

## Overview
This project applies MATLAB to reconstruct and visualize a 3D flight trajectory using smartphone sensor data. Linear acceleration and atmospheric pressure measurements are processed to estimate the aircraft's position and altitude over time, which are then used to generate a three-dimensional representation of the flight path. The current implementation has been tested using data recorded during the descent phase of a flight, with pitch, roll, and azimuth data reserved for potential future improvements.

## How To Run
### Using test data
1. Download the `Flight Path Reconstruction` folder.
2. Open `flightpathreconstructor` in MATLAB.
3. Locate the following line of code: 'raw_data=readmatrix("test 2.csv");'.
4. Change the filename to `test 1.csv` or `test 2.csv` depending on which dataset you want to use.
5. Run the script.

### Using your own recorded data
The reconstruction script requires input data in a specific format. Follow the steps below to record and import your own data.

#### Recording the data
1. Download the `Physics Toolbox Suite` app on your mobile device.
2. Open the app, scroll down, and select `Multi Record`.
3. Select `Linear Acceleration` and `Barometer`.
4. Press `Start Recording` to begin recording your data.
5. Once you have finished recording, press `Stop Recording`.
6. Press `Share CSV File` and send the file to yourself.
7. Save the `.csv` file in the folder `Flight Path Reconstruction`.

#### Running the reconstruction
9. Open `flightpathreconstructor` in MATLAB.
10. Locate this line of code: 'raw_data=readmatrix("test 2.csv");'.
11. Replace `test 2.csv` with the filename of your recorded `.csv` file.
12.  Run the script.

### Viewing the Reconstruction
The final figure displays the reconstructed flight path in 3D. Use your mouse or trackpad to rotate the plot and explore the flight path from different angles.
