function AR = roundnv(A,res)

  [m,n] = size(A);
  
  factrep = repmat(10.^(-res),[m 1]);
  AR      = round(A.*factrep)./factrep;
end