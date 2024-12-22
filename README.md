# EasyPD

### A MATLAB-based particle dynamics code
 - Author: Daniel Hortelano-Roig
 - Organisation: University of Oxford
 - Contact: daniel.hortelanoroig@gmail.com

EasyPD is a vectorised particle dynamics code. The intention is to adopt a simple-to-use modular design to facillitate research, so that each module can be independently modified or replaced. An example of such a module would be the specification of the forces between particles. This is a work in progress.

## Requirements

 - MATLAB (2019b+ preferred)

## Capabilities

 - Newtonian gravity

## Folder structure

 - input: contains input files
 - output: contains output files
 - scr: contains source files

## How to run

To run a simulation, you must use a specific input file. One way of doing this is via the following

 - `cd /path/to/src`
 - `run('/path/to/input/inputfile.m')`
 - `run('EasyPD.m')`