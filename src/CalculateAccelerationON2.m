function [an] = CalculateAccelerationON2(rn,mn,G,a)

% Interaction matrix: (rj - ri) / |rj - ri|^3

N = size(rn,1);
an = zeros(N,3);

for i = 1:N
    for j = 1:N

        if i == j
            continue
        end

        Ra = CalculateSoftDistance(rn(j,:) - rn(i,:),a);

        an(i,:) = an(i,:) + G * mn(j) * (rn(j,:) - rn(i,:)) / Ra^3;
    end
end

end