function [kineticEnergy] = KEGravity(stateS,~,~)
%% Extraction

vn = stateS.vn;
mn = stateS.mn;

%%

kineticEnergy = (1/2) * dot(mn, dot(vn,vn,2));

end