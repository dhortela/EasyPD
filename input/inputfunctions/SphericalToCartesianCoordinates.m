function [xVec, yVec, zVec] = SphericalToCartesianCoordinates(rVec,thetaVec,phiVec)

xVec = rVec .* cos(phiVec) .* sin(thetaVec);
yVec = rVec .* sin(phiVec) .* sin(thetaVec);
zVec = rVec .* cos(thetaVec);

end