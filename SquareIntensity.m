function I=SquareIntensity(theta,len,beamw)

  I = len./beamw.*sind(theta);
  I(find(I>1.0)) = ones(size(find(I>1.0)));
end