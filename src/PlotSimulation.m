function [plotS] = PlotSimulation(stateS,~,compS,plotS)
%% Extraction

curstep = compS.curstep;
plotparticlesfreq = plotS.plotparticlesfreq;
plotenergyfreq = plotS.plotenergyfreq;

%%

if mod(curstep, plotparticlesfreq) == 0
    
    [plotS] = PlotParticles(stateS,compS,plotS);
end

if mod(curstep, plotenergyfreq) == 0
    
    [plotS] = PlotEnergy(stateS,compS,plotS);
end