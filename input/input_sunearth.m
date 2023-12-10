%% Input file -- Daniel Hortelano Roig (08/11/2023) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Sections are the following:
% 1) META INFORMATION
% 2) PARAMETERS
% 3) INITIAL CONDITIONS
% 4) EasyPD PARAMETERS
%       - Parallelisation
%       - Meshing
%       - Time integrator
%       - Simulation time
%       - Plotting
%       - Mobility law
%       - Dislocation nodes (rn) and segments (links)
% 5) INFO & CHECKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear % Removes all items from workspace
dbstop if error % Applies debugging breakpoint instead of error
%dbstop if warning % Applies debugging breakpoint instead of warning
close all

rng(420); % Random number generator fixed seed

%% META INFORMATION %%

%%% Input paths and folders

% Functions designed for use in the input file:
if ~exist('./inputfunctions/', 'dir')
       mkdir('inputfunctions/');
end
addpath(genpath('inputfunctions/'));

% Initial nodal network figures:
if ~exist('./figures/', 'dir')
       mkdir('figures/');
end

%% PARAMETERS %%

%%% Define structs

physS = struct; % Physical parameters
compS = struct; % Computational parameters
stateS = struct; % State parameters
plotS = struct; % Plotting

%% Define variables

%%% Physical parameters

physS.G = 6.67408e-11; % Gravitational constant
compS.a = 0; % Softening parameter

%%% Skip calculations

compS.calcenergyfreq = 1;

%%% Time parameters

compS.maxsimtime = 3.154e7; % Max simulation time
%compS.maxsimtime = 3.154e9;
compS.dt = 5e4; % Time step size
%compS.dt = 1e6;
%compS.dt = 1e5;
compS.numtimesteps = ceil(compS.maxsimtime/compS.dt);
compS.curstep = 1; % Current step
compS.simtime = 0; % Current simulation time

%%% Plotting

plotS.plotparticlesfreq = 1; % 0,1: plot every time; Inf: plot never
plotS.plotenergyfreq = 100;

plotS.boxviewsize = 1.8e11;
%plotS.boxviewsize = 8e11;
plotS.viewangle = [0 90];

% Frame setup:
plotS.doframesaving = 0;
plotS.framecount = 0;
plotS.outputsmovieframespath = append('../output/frames/testsim/');
plotS.frameext = '.jpg';
if ~exist(append(plotS.outputsmovieframespath), 'dir')
       mkdir(append(plotS.outputsmovieframespath));
end

%%% Function handles

% Time integrator:
compS.ftimeintegrator = @LeapFrog;
%compS.timeintegrator = @ForwardEuler;

% Acceleration:
compS.facccalculation = @CalculateAccelerationVectorised;

% Kinetic energy:
compS.fkineticenergy = @KEGravity;

% Potential energy:
compS.fpotentialenergy = @PEGravity;


%% Initial conditions

%%% Masses

earthmass = 5.9722e24;
sunmass = 1.989e30;
mn = [earthmass; sunmass];

%%% Positions

earthpos = [1.496e11 0 0];
sunpos = [0 0 0];

rn = [earthpos; sunpos];

%%% Velocities

earthvel = [0 2.97827e4 0];
%earthvel = [0 3.5e4 0];
sunvel = [0 0 0];

vn = [earthvel; sunvel];

%%% Fill struct

stateS.mn = mn;
stateS.rn = rn;
stateS.vn = vn;
