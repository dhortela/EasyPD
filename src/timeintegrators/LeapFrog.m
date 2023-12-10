function [stateS] = LeapFrog(stateS,physS,compS)
%% Extraction

dt = compS.dt;
facccalculation = compS.facccalculation;

%%

an = facccalculation(stateS,physS,compS);

stateS.vn = stateS.vn + an .* dt/2;
stateS.rn = stateS.rn + stateS.vn .* dt;

an = facccalculation(stateS,physS,compS);

stateS.vn = stateS.vn + an .* dt/2;

%% Insertion

stateS.an = an;

end