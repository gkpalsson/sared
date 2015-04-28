function I= GaussIntensity(theta,s1,s2,sigma)
    % s1 and s2 are L/2, half of the sample length
    % each part of the erf is the result of integrating half the sample
    I = ( erf(s2*sind(theta)/sqrt(2.0)/sigma) +...
          erf(s1*sind(theta)/sqrt(2.0)/sigma) )/2.0;
        
    
end