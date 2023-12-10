function [stateS,compS] = UpdateTime(stateS,~,compS)
%% Extraction

dt = compS.dt;
simtime = compS.simtime;
curstep = compS.curstep;

%%

simtime = simtime + dt;
curstep = curstep + 1;

%% Insertion

compS.simtime = simtime;
compS.curstep = curstep;

end