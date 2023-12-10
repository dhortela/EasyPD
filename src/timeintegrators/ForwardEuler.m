function [stateS] = ForwardEuler(stateS,physS,compS)
%% Extraction

rn = stateS.rn;
vn = stateS.vn;

dt = compS.dt;
facccalculation = compS.facccalculation;

%%

an = facccalculation(stateS,physS,compS);

vn = vn + an .* dt;
rn = rn + vn .* dt;

%% Insertion

stateS.rn = rn;
stateS.vn = vn;
stateS.an = an;

end