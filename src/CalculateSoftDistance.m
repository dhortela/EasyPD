function [softDistance] = CalculateSoftDistance(inVec,a)

softDistance = sqrt(dot(inVec,inVec) + a^2);

end