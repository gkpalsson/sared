function vector = makeVector(p,indata,mask,start,rep,repSize)
  
  N = length(indata);
  vector = zeros(N,1);
  k = 1;
  l = 0;
  foundRep = 0;
  for i = 1:N
    if mask(i) == 1
      if rep(i) == 1
        if foundRep 
          k = k + repSize;
          foundRep = 0;
        end
        vector(i) = p(start+k);
        k = k + 1;
      else
        foundRep = 1;
        vector(i) = p(start + k + l);
        l = l+1;
      end
      if l == repSize
        l = 0;
      end
    elseif mask(i) == 0 && foundRep
      l = 0;
      vector(i) = indata(i);
    else
      vector(i) = indata(i);
    end
  end
end