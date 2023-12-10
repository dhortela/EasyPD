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

compS.calcenergyfreq = Inf;

%%% Time parameters

%compS.maxsimtime = 3.154e7; % Max simulation time
compS.maxsimtime = 3.154e10;
%compS.dt = 5e4; % Time step size
compS.dt = 5e3;
%compS.dt = 1e6;
%compS.dt = 1e5;
%compS.numtimesteps = ceil(compS.maxsimtime/compS.dt);
compS.numtimesteps = 1e8;
compS.curstep = 1; % Current step
compS.simtime = 0; % Current simulation time

%%% Plotting

plotS.plotparticlesfreq = Inf; % 0,1: plot every time; Inf: plot never
plotS.plotenergyfreq = Inf;

%plotS.boxviewsize = 1.8e11;
plotS.boxviewsize = 5e11;
plotS.viewangle = [0 90];
%plotS.viewangle = [45 45];

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

plutomass = 0.013e24;
neptunemass = 102e24;
uranusmass = 86.8e24;
saturnmass = 568e24;
jupitermass = 1898e24;
marsmass = 0.642e24;
earthmass = 5.9722e24;
venusmass = 4.87e24;
mercurymass = 0.33e24;
sunmass = 1.989e30;

mn = [sunmass; mercurymass; venusmass; earthmass; marsmass; jupitermass; saturnmass; uranusmass; neptunemass; plutomass];

%%% Positions

plutopos = [5906e11 0 1e-9];
neptunepos = [45.15e11 0 0];
uranuspos = [28.67e11 0 0];
saturnpos = [14.32e11 0 0];
jupiterpos = [7.785e11 0 0];
marspos = [2.28e11 0 0];
earthpos = [1.496e11 0 0];
venuspos = [1.082e11 0 0];
mercurypos = [0.579e11 0 0];
sunpos = [0 0 0];

rn = [sunpos; mercurypos; venuspos; earthpos; marspos; jupiterpos; saturnpos; uranuspos; neptunepos; plutopos];

%%% Velocities

plutovel = [0 0.47e4 0];
neptunevel = [0 0.54e4 0];
uranusvel = [0 0.68e4 0];
saturnvel = [0 0.97e4 0];
jupitervel = [0 1.31e4 0];
marsvel = [0 2.41e4 0];
earthvel = [0 2.97827e4 0];
venusvel = [0 3.5e4 0];
mercuryvel = [0 4.74e4 0];
sunvel = [0 0 0];

vn = [sunvel; mercuryvel; venusvel; earthvel; marsvel; jupitervel; saturnvel; uranusvel; neptunevel; plutovel];

%%% Fill struct

stateS.mn = mn;
stateS.rn = rn;
stateS.vn = vn;
