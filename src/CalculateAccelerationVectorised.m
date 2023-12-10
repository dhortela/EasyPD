function [an] = CalculateAccelerationVectorised(stateS,physS,compS)
%% Extraction

rn = stateS.rn;
mn = stateS.mn;

G = physS.G;

a = compS.a;

%%

% Interaction matrix: (rj - ri) / |rj - ri|^3

N = size(rn,1);

X = rn(:,1) - rn(:,1)';
Y = rn(:,2) - rn(:,2)';
Z = rn(:,3) - rn(:,3)';

distvecmat = cat(3,X,Y,Z); % distvecmat(j,i,:) = rn(j,:) - rn(i,:)
distmat = vecnorm(distvecmat,2,3); % distmat(j,i) = |rn(j,:) - rn(i,:)|

Ramat = sqrt(distmat .^ 2 + a^2); % Soft distance

interactionMat = distvecmat ./ (Ramat .^ 3);

interactionMat(isnan(interactionMat)) = 0;

physintmat = mn .* interactionMat;

an = G * reshape(sum(physintmat,1),N,3);

end