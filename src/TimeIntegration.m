function [stateS] = TimeIntegration(stateS,physS,compS)
%% Extraction

ftimeintegrator = compS.ftimeintegrator;

%%

[stateS] = ftimeintegrator(stateS,physS,compS);

end