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
%compS.a = 1.496e7; % Softening parameter
compS.a = 1.496e4;

%%% Skip calculations

compS.calcenergyfreq = Inf;

%%% Time parameters

%compS.maxsimtime = 3.154e7; % Max simulation time
compS.maxsimtime = 3.154e7;

%compS.maxsimtime = 400;
%compS.dt = 5e4; % Time step size
%compS.dt = 5e5;
%compS.dt = 1e6;
%compS.dt = 1e5;
%compS.dt = 5e1;
compS.dt = 1e2;

compS.numtimesteps = ceil(compS.maxsimtime/compS.dt);
compS.curstep = 1; % Current step
compS.simtime = 0; % Current simulation time

%%% Plotting

plotS.plotparticlesfreq = 10000; % 0,1: plot every time; Inf: plot never
%plotS.plotenergyfreq = 200;
plotS.plotenergyfreq = Inf;

%plotS.boxviewsize = 1.5e11;
plotS.boxviewsize = 5e11;
%plotS.boxviewsize = 5e7;
%plotS.viewangle = [0 90];
plotS.viewangle = [45 45];

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

N = 199; % Total number of masses on sphere surface

earthmass = 5.9722e24;
%sunmass = 1.989e30;
sunmass = 1.989e26;
mn = sunmass;
mn = [mn; earthmass*ones(N,1)];

%%% Positions

%earthradius = 1.496e11;

%rVec = 1.496e11 * ones(N,1);
rVec = 1.496e7 * linspace(0.2,1,N)';
%thetaVec = linspace(0,pi,N)';
%thetaVec = pi * sin(rand(N,1)*pi/2);
%thetaVec = asin(rand(N,1));
thetaVec = -asin(1 - 2*rand(N,1)) + pi/2;
%phiVec = linspace(0,2*pi,N)';
%phiVec = 2*pi * rand(N,1);
phiVec = 2*pi * rand(N,1);


[xVec, yVec, zVec] = SphericalToCartesianCoordinates(rVec,thetaVec,phiVec);

sunpos = [0 0 0];

rn = sunpos;
rn = [rn; [xVec yVec zVec]];

%%% Velocities

%earthvel = [0 2.97827e4 0];
sunvel = [0 2.97827e10 0];

vn = sunvel;
vn = [vn; zeros(N,3)];

%%% Fill struct

stateS.mn = mn;
stateS.rn = rn;
stateS.vn = vn;
