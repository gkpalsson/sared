function redchi = redchisqr(p,S)

  sim = model(p,S);
  %q4 = S.Q.^4;
 
  int(:,1) = S.Iuu;
  int(:,2) = S.Iud;
  int(:,3) = S.Idu;
  int(:,4) = S.Idd;
 % redchi = 1/(S.Ndata - S.M+S.N+S.O+3)*sum( abs(log10(sim) - log10(S.I) )./(sqrt(S.I)*log(10).*S.I) );
 
 redchi = 1/(S.Ndata - S.M+S.N+S.O+S.P+3)*sum( abs(log10(sim) - log10(int) ) );
 redchi = sum(redchi);
  %redchi = sqrt( sum(  (sim./q4 - S.I./q4).^2 ) );
  %redchi = sqrt( sum (sim-S.I).^2 );
end