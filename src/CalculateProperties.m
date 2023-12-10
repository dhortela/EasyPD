function [stateS] = CalculateProperties(stateS,physS,compS)
%% Extraction

curstep = compS.curstep;
calcenergyfreq = compS.calcenergyfreq;

%%

if mod(curstep, calcenergyfreq) == 0

    [H,KE,PE] = CalculateEnergy(stateS,physS,compS);
    
    stateS.t(curstep) = compS.simtime;
    stateS.H(curstep) = H;
    stateS.KE(curstep) = KE;
    stateS.PE(curstep) = PE;
end


end