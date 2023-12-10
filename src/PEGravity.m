function [potentialEnergy] = PEGravity(stateS,physS,~)
%% Extraction

rn = stateS.rn;
mn = stateS.mn;
G = physS.G;

%%

N = size(rn,1);

potentialEnergy = 0;

for i = 1:N
    for j = 1:N
        
        if i == j
            continue
        end
        
        % Ra = CalculateSoftDistance(posVec(j,:) - posVec(i,:),a);

        potentialEnergy = potentialEnergy - G * mn(j) * mn(i) / norm(rn(j,:) - rn(i,:));
    end
end

potentialEnergy = potentialEnergy / 2; % To negate double-counting

end