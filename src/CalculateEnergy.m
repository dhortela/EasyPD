function [H,KE,PE] = CalculateEnergy(stateS,physS,compS)
%% Extraction

fkineticenergy = compS.fkineticenergy;
fpotentialenergy = compS.fpotentialenergy;

%%

KE = fkineticenergy(stateS,physS,compS);

PE = fpotentialenergy(stateS,physS,compS);

H = KE + PE;

end