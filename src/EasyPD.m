%===============================================================%
% Daniel Hortelano Roig (06/11/2023)
% daniel.hortelanoroig@materials.ox.ac.uk

% N-body simulation.

% Fixed time step.
% Code is developed to allow for later expansion to include arbitrary time
% step size -- note that in such a case the total number of time steps
% would be unknown before the end of the simulation.
%===============================================================%

% Add necessary paths:
run AddPaths.m

% Ensure existence of necessary input variables:
[stateS,physS,compS] = InputCompletion(stateS,physS,compS);

%% Start of simulation loop

while compS.simtime < compS.maxsimtime

    % Energy calculation:
    [stateS] = CalculateProperties(stateS,physS,compS);
    
    % Plot:
    [plotS] = PlotSimulation(stateS,physS,compS,plotS);

    % Time integration:
    [stateS] = TimeIntegration(stateS,physS,compS);
    
    [stateS,compS] = UpdateTime(stateS,physS,compS);

end
