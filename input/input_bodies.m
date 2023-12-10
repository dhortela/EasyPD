%% Define structs

figS = struct; % Contains figures

%% Define variables

%%% Physical parameters

G = 6.67408e-11; % Gravitational constant
a = 0; % Softening parameter

%%% Time parameters

maxsimtime = 10; % Max simulation time
dt = 0.01; % Time step size
numtimesteps = ceil(maxsimtime/dt);
curstep = 1; % Current step
simtime = 0; % Current simulation time

%%% Seed

rng(420); % Random number generator fixed seed

%%% Plotting

plotparticlesfreq = 1; % 0,1: plot every time; Inf: plot never
plotenergyfreq = 100;

%%% Time integration

timeintegrator = @ForwardEuler;

%% Initial conditions

%%% Masses

N = 10; % N number of bodies
mvec = 1e10*ones(1,1); % N masses
mvec = [mvec; 1e1*ones(N-1,1)];

%%% Positions

% Particles uniformly distributed in a sphere
maxr = 0.1;
rpos = linspace(0,maxr,N)';
thetapos = linspace(0,pi,N)';
phipos = linspace(0,2*pi,N)';

[xpos, ypos, zpos] = SphericalToCartesianCoordinates(rpos,thetapos,phipos);

%posvec = zeros(N,3);
posvec = [xpos, ypos, zpos];

%%% Velocities

% maxvelmag = 5;
% minvelmag = -5;
% velvec = rand(N,3) * (maxvelmag - minvelmag) + minvelmag;

% v = |r| * rhat
%velvec = zeros(N,3);
velvec = rpos .* (posvec ./ vecnorm(posvec,2,2)); % vecnorm(A,2,2): 2-norm on dim 2

velvec(any(isnan(velvec),2),:) = [0 0 0];

%% Initialisation of tracking vectors

timevec = zeros(numtimesteps,1); % simtime at each step
H = zeros(numtimesteps,1); % Total energy
KE = zeros(numtimesteps,1); % Kinetic energy
PE = zeros(numtimesteps,1); % Potential energy
