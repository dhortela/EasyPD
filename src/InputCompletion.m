function [stateS,physS,compS] = InputCompletion(stateS,physS,compS)
%% Extraction

N = size(stateS.rn,1);

numtimesteps = compS.numtimesteps;

%%

if ~isfield(stateS, 't')
    stateS.t = zeros(numtimesteps,1);
end

if ~isfield(stateS, 'H')
    stateS.H = zeros(numtimesteps,1);
end

if ~isfield(stateS, 'KE')
    stateS.KE = zeros(numtimesteps,1);
end

if ~isfield(stateS, 'PE')
    stateS.PE = zeros(numtimesteps,1);
end

if ~isfield(stateS, 'an')
    stateS.an = zeros(N,3);
end

end