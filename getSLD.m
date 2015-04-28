function [sld,ndens] = getSLD(chem,dens,wavelength,probe)
  
  [M,factor] = MolMass(chem);
  
  constants = fundamentalPhysicalConstantsFromNIST();
  Na = constants.Avogadro_constant.value;
  
  weighted_b = get_weighted_bi_incl_abs(chem);
  
  % lambda=1.798 is the wavelength at which the absorption cross section
  % is measured and tabulated.
  % b_a = b_a/1.798*wavelength/4/pi*2*pi/wavelength = b_a/1.798/2
  
  weighted_b = complex(real(weighted_b*1e-5),-imag(weighted_b)*1e-8/1.798/2);
  
  sld   = weighted_b/M*dens*1e-24*Na;     % (bi/ (xiMi)/dens) = bi*dens/(xi*Mi) , bi*xi*Mi*dens
  ndens = dens*Na*1e-24/M*sum(factor);
  if probe == 1
  
%  xraydb = load('HenkeDatabase.mat');
%  xraydb = xraydb.db;
%  
%  E_ev = constants.Planck_constant_in_eV_s.value*constants.speed_of_light_in_vacuum.value/(wavelength*1e-10);
%  
%  
%    closest_E = find(xraydb{1}.energies >= E_ev);
%    closest_E = closest_E(1);
% 
%  for i = 1:length(xraydb)
%    varname = genvarname(char(xraydb{i}.elem));
%    eval([varname '= complex(xraydb{i}.f1(closest_E),xraydb{i}.f2(closest_E));']);
%  end
%  
%  D = H;
%  save('XrayF.mat','H','D','He','Li','Be','B','C','N','O','F','Ne','Na','Mg','Al','Si','P','S','Cl','Ar','K','Ca','Sc','Ti','V','Cr','Mn','Fe','Co','Ni','Cu','Zn','Ga','Ge','As','Se','Br','Kr','Rb','Sr',...
%   'Y','Zr','Nb','Mo','Tc','Ru','Rh','Pd','Ag','Cd','In','Sn','Sb','Te','I','Xe','Cs','Ba','La','Ce','Pr','Nd','Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Hf','Ta','W','Re','Os','Ir','Pt',...
%   'Au','Hg','Tl','Pb','Bi','Po','At','Rn','Ac','Th','Pa','U');


 weighted_f = get_weighted_f(chem);

 r_0 = 2.8179403267e-5; % Thomson scattering length in Angstrom
 sld = ndens*r_0*complex(real(weighted_f),-imag(weighted_f));
 
  end
% ndens
% refractive = 1 - sld/(2*pi)*wavelength^2

 
 
 
 
 
 %[db] = parse_new_ns_database('new_neutron_sclengths_clean.dat');
%[dbabs] = parse_abs();
  %[db] = parse_ns_database('DeBe_NeutronNews.dat');
%[at] = parse_atomicweight_database('AtomicWeights.dat');
  
  %bV  = -0.3824e-5; % A
  %bV  = -0.443e-5;
  %bFe = 9.45e-5;   % A
  %dens*Na/M*1e-24
  %(1*bV)*dens*Na/M*1e-24
  
%str = '';
%out = '';
% atomic_mass = 0;
% 
%   for i = 1:length(db)
%     elem = db{i}.Isotope
%     z    = db{i}.Z
%     scatt_length(i) = db{i}.bcr(1);
%     atomic_mass = 0;
%     for j = 1:length(at)
%       a = char(at{j}.Isotope);
%      
%       if strcmp(a,elem) && (z == at{j}.Z)
%         atomic_mass = at{j}.averageatomicmass;
%         idx         = j;
%         disp(['found isotope',a,elem])
%         disp(['found z ',num2str(z),' ',num2str(at{j}.Z)])
%       end
%     end
%     if atomic_mass == 0
%       disp(['warning no atom found for',db{i}.Isotope])
%     else
% 
%     scatt_length(i)
%     atomic_mass
%     if scatt_length(i) == 9999
%       scatt_length(i) = 0;
%     end
%     str = [str, elem,' = ',num2str(scatt_length(i)*atomic_mass),';'];
%     out = [out,[str{i*4-3} str{i*4-3+1} str{i*4-3+2} str{i*4-3+3}]]
%     end
%     pause
%   end  

% str = '';
% out = '';
% atomic_mass = 0;
%     
%     theabs = zeros(length(db));
%   for i = 1:length(db)
%     elem = db{i}.Isotope
%     z    = db{i}.Z
%     scatt_length(i) = db{i}.bcr(1);
% 
%     for j = 1:length(dbabs)
%       a = char(dbabs{j}.Isotope);
%       
%       if strcmp(a,elem) && (z == dbabs{j}.Iso)
%         theabs(i) = dbabs{j}.abs;
%         idx         = j;
%         disp(['found isotope',a,elem])
%         disp(['found z ',num2str(z),' ',num2str(dbabs{j}.Z)])
%       end
%     end
%     
%     scatt_length(i)
% 
%     if scatt_length(i) == 9999
%       scatt_length(i) = 0;
%     end
% 
%     str = [str, elem,' = ',num2str(scatt_length(i)),'+ 1i*',num2str(theabs(i)),';']
%     out = [out,[str{i*6-5} str{i*6-5+1} str{i*6-5+2} str{i*6-5+3} str{i*6-5+4} str{i*6-5+5}]]
%     pause
%   end  

end