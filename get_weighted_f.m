% function MolMass.m
% The function MolMass calculates the molar weight of a substance.
% 
% function call: MM = MolMass(substance)
% 
% substance is a string of the chemical formula of s substance.
% example:	MM = MolMass('Fe2(SO4)3');
% 
% substance can also be a vector of substances opened by '[' and divided by space, comma or semicolon.
% examples:
% 			MM = MolMass('[Fe2(SO4)3 CuSO4 NaOH]');
% 			MM = MolMass('[H2SO4;H2O;P;Cl2]');
% 			MM = MolMass('[C3H5(OH)3,C3H7OH,C12H22O11,NaCl]');
% 
% To distinguish charched substances the symbols '+' and '-' can be used.
% exampels:
% 			MM = MolMass('Fe2+')  --->  MM = 55.8470		%it means one mol of Fe2+
% 			MM = MolMass('Fe3+')  --->  MM = 55.8470		%it means one mol of Fe3+
% 		but	MM = MolMass('Fe2')   --->  MM = 111.6940		%it means two moles of Fe
% 
% 
% ultimate Date:     18.12.2009
% version:           1.4
% copyright:         E. Giebler, TU Dresden, IfA (1999-2009)


function MM = get_weighted_bi(substance)

for char_index = 1:length(substance),														% first syntax check
   if isempty(findstr(substance(char_index),'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789()[];, +-".')),
      error_message = ['Wrong symbol ' substance(char_index) ' in the formula!']
      error(error_message)
   end%if
end%for

substance_number = 1;
single_substance = '';
char_index=0;

% ---------------------replace redundant spaces--------------------------
if   ~isempty(findstr('  ',substance))...
   | ~isempty(findstr(' ]',substance))...
   | ~isempty(findstr('[ ',substance))
  while ~isempty(findstr('  ',substance))
    substance = strrep(substance,'  ',' ');
  end % while  ~isempty(findstr('  ',substance))
    substance = strrep(substance,' ]',']');
    substance = strrep(substance,'[ ','[');
end %if findstr(...

if substance(1) == '[',																		% vector of substances
char_index = char_index + 1;
   while char_index < length(substance)
      char_index = char_index + 1;
      if ~isempty(findstr(substance(char_index),'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789()+-".'))
         single_substance(end+1) = substance(char_index);
      elseif ~isempty(findstr(substance(char_index),' ,;]'))
         MM(substance_number) = MolMass(single_substance);
         single_substance = '';
         substance_number = substance_number+1;
         while char_index < length(substance) &  ~isempty(findstr(substance(char_index+1),' ,;]'))
            char_index = char_index + 1;
         end%while
      	if substance(char_index) == ']'
         	char_index = length(substance);
      	end%if
      end%if
   end%while
 %  MM(substance_number) = MolMass(single_substance);
else														                                % single substance only
   
% molar masses of the elements:
% OLD values from NIST
%H = -3.7687;He = 13.0485;Li = -13.1883;Be = 70.2049;B = 57.302;C = 79.8236;N = 131.1029;O = 92.8447;F = 107.417;Ne = 92.1408;Na = 83.4529;Mg = 130.6397;Al = 93.0593;Si = 116.5297;P = 158.8954;S = 91.2905;Cl = 339.5353;Ar = 76.2609;K = 143.4908;Ca = 188.3685;Sc = 552.5081;Ti = -164.5671;V = -19.48;Cr = 189.006;Mn = -204.9189;Fe = 527.7371;Co = 146.7437;Ni = 604.5422;Cu = 490.4503;Zn = 371.4266;Ga = 508.142;Ge = 594.5666;As = 492.9841;Se = 629.3351;Br = 542.9484;Kr = 654.4858;Rb = 605.9669;Sr = 615.0994;Y = 689.0204;Zr = 653.1653;Nb = 655.3616;Mo = 644.2438;Tc = 666.4;Ru = 710.5362;Rh = 605.0844;Pd = 628.9481;Ag = 638.7956;Cd = 547.4455;In = 466.7364;Sn = 738.9741;Sb = 678.2038;Te = 740.0974;I = 670.0556;Xe = 645.9645;Cs = 720.3475;Ba = 696.2514;La = 1144.5815;Ce = 678.1619;Pr = 645.357;Nd = 1109.2287;Pm = 1827;Sm = 120.2904;Eu = 1097.1808;Gd = 1022.1445;Tb = 1172.869;Dy = 2746.3007;Ho = 1321.0919;Er = 1302.9499;Tm = 1194.3649;Yb = 2150.9245;Lu = 1261.5128;Hf = 1374.3884;Ta = 1250.3501;W = 893.4673;Re = 1713.1053;Os = 2035.4931;Ir = 2037.5034;Pt = 1872.7507;Au = 1502.8548;Hg = 2545.9137;Tl = 1793.668;Pb = 1948.8101;Bi = 1783.0206;Po = 0;At = 0;Rn = 0;Fr = 0;Ra = 2260;Ac = 0;Th = 2392.3129;Pa = 2102.4265;U = 2003.4894;Np = 2500.35;Pu = 0;Am = 2016.9;Cm = 0;
% NEW values from 
% LANDOLT-BÖRNSTEIN, New Series I/16A (Ed. H. Schopper) Chap.6, Springer, Berlin 2000

%H = -3.7706;He = 13.0485;Li = -13.1883;Be = 70.2049;B = 57.302;C = 79.8525;N = 131.1029;O = 92.8767;F = 107.417;Ne = 92.8269;Na = 83.4529;Mg = 130.6397;Al = 93.0593;Si = 116.5749;P = 158.8954;S = 91.2905;Cl = 339.6133;Ar = 76.2609;K = 143.4908;Ca = 188.3685;Sc = 543.9665;Ti = -161.3121;V = -22.5671;Cr = 189.006;Mn = -206.0177;Fe = 527.7371;Co = 146.7437;Ni = 604.5422;Cu = 490.4503;Zn = 371.4266;Ga = 508.142;Ge = 594.5666;As = 492.9841;Se = 629.3351;Br = 542.5488;Kr = 654.4858;Rb = 605.1122;Sr = 615.0994;Y = 689.0204;Zr = 653.1653;Nb = 655.3616;Mo = 644.2438;Tc = 666.4;Ru = 709.5254;Rh = 607.1425;Pd = 628.9481;Ag = 638.7956;Cd = 542.949;In = 466.7364;Sn = 738.9741;Sb = 678.2038;Te = 724.785;I = 780.4625;Xe = 615.767;Cs = 720.3475;Ba = 696.2514;La = 1144.5815;Ce = 678.1619;Pr = 645.357;Nd = 1109.2287;Pm = 1827;Sm = 0;Eu = 805.4097;Gd = 1493.9035;Tb = 1166.512;Dy = 2746.3007;Ho = 1392.0119;Er = 1302.9499;Tm = 1194.3649;Yb = 2147.4636;Lu = 1261.5128;Hf = 1386.8828;Ta = 1250.3501;W = 874.164;Re = 1713.1053;Os = 2035.4931;Ir = 2037.5034;Pt = 1872.7507;Au = 1556.0358;Hg = 2539.4947;Tl = 1793.668;Pb = 1947.9812;Bi = 1783.0206;Po = 0;At = 0;Rn = 0;Fr = 0;Ra = 2260;Ac = 0;Th = 2392.3129;Pa = 2102.4265;U = 2003.4894;Np = 2500.35;Pu = 0;Am = 2016.9;Cm = 2346.5;
%H = -3.7409;He = 3.26;Li = -1.9;Be = 7.79;B = 5.3;C = 6.6484;N = 9.36;O = 5.805;F = 5.654;Ne = 4.6;Na = 3.63;Mg = 5.375;Al = 3.449;Si = 4.1507;P = 5.13;S = 2.847;Cl = 9.5792;Ar = 1.909;K = 3.67;Ca = 4.7;Sc = 12.1;Ti = -3.37;V = -0.443;Cr = 3.635;Mn = -3.75;Fe = 9.45;Co = 2.49;Ni = 10.3;Cu = 7.718;Zn = 5.68;Ga = 7.288;Ge = 8.185;As = 6.58;Se = 7.97;Br = 6.79;Kr = 7.81;Rb = 7.08;Sr = 7.02;Y = 7.75;Zr = 7.16;Nb = 7.054;Mo = 6.715;Tc = 6.8;Ru = 7.02;Rh = 5.9;Pd = 5.91;Ag = 5.922;Cd = 4.83;In = 4.065;Sn = 6.225;Sb = 5.57;Te = 5.68;I = 6.15;Xe = 4.69;Cs = 5.42;Ba = 5.07;La = 8.24;Ce = 4.84;Pr = 4.58;Nd = 7.69;Pm = 12.6;Sm = 0;Eu = 5.3;Gd = 9.5;Tb = 7.34;Dy = 16.9;Ho = 8.44;Er = 7.79;Tm = 7.07;Yb = 12.41;Lu = 7.21;Hf = 7.77;Ta = 6.91;W = 4.755;Re = 9.2;Os = 10.7;Ir = 10.6;Pt = 9.6;Au = 7.9;Hg = 12.66;Tl = 8.776;Pb = 9.401;Bi = 8.532;Po = 0;At = 0;Rn = 0;Fr = 0;Ra = 10;Ac = 0;Th = 10.31;Pa = 9.1;U = 8.417;Np = 10.55;Pu = 0;Am = 8.3;Cm = 9.5;
%D = 6.674;

%H = -3.7409+ 1i*0.3326;He = 3.26+ 1i*0.00747;Li = -1.9+ 1i*70.5;Be = 7.79+ 1i*0;B = 5.3+ 1i*767;C = 6.6484+ 1i*0.0035;N = 9.36+ 1i*1.9;O = 5.805+ 1i*0.00019;F = 5.654+ 1i*0;Ne = 4.6+ 1i*0.039;Na = 3.63+ 1i*0;Mg = 5.375+ 1i*0.063;Al = 3.449+ 1i*0;Si = 4.1507+ 1i*0.171;P = 5.13+ 1i*0;S = 2.847+ 1i*0.53;Cl = 9.5792+ 1i*33.5;Ar = 1.909+ 1i*0.675;K = 3.67+ 1i*2.1;Ca = 4.7+ 1i*0.43;Sc = 12.1+ 1i*0;Ti = -3.37+ 1i*6.09;V = -0.443+ 1i*5.08;Cr = 3.635+ 1i*3.05;Mn = -3.75+ 1i*0;Fe = 9.45+ 1i*2.56;Co = 2.49+ 1i*0;Ni = 10.3+ 1i*4.49;Cu = 7.718+ 1i*3.78;Zn = 5.68+ 1i*1.11;Ga = 7.288+ 1i*2.75;Ge = 8.185+ 1i*2.2;As = 6.58+ 1i*0;Se = 7.97+ 1i*11.7;Br = 6.79+ 1i*6.9;Kr = 7.81+ 1i*25;Rb = 7.08+ 1i*0.38;Sr = 7.02+ 1i*1.28;Y = 7.75+ 1i*0;Zr = 7.16+ 1i*0.185;Nb = 7.054+ 1i*0;Mo = 6.715+ 1i*2.48;Tc = 6.8+ 1i*0;Ru = 7.02+ 1i*2.56;Rh = 5.9+ 1i*0;Pd = 5.91+ 1i*6.9;Ag = 5.922+ 1i*63.3;Cd = 4.83+ 1i*2520;In = 4.065+ 1i*193.8;Sn = 6.225+ 1i*0.626;Sb = 5.57+ 1i*4.91;Te = 5.68+ 1i*4.7;I = 6.15+ 1i*0;Xe = 4.69+ 1i*23.9;Cs = 5.42+ 1i*0;Ba = 5.07+ 1i*1.1;La = 8.24+ 1i*8.97;Ce = 4.84+ 1i*0.63;Pr = 4.58+ 1i*0;Nd = 7.69+ 1i*50.5;Pm = 12.6+ 1i*0;Sm = 0+ 1i*5922;Eu = 5.3+ 1i*4530;Gd = 9.5+ 1i*49700;Tb = 7.34+ 1i*0;Dy = 16.9+ 1i*994;Ho = 8.44+ 1i*0;Er = 7.79+ 1i*159;Tm = 7.07+ 1i*0;Yb = 12.41+ 1i*34.8;Lu = 7.21+ 1i*74;Hf = 7.77+ 1i*104.1;Ta = 6.91+ 1i*20.6;W = 4.755+ 1i*18.3;Re = 9.2+ 1i*89.7;Os = 10.7+ 1i*16;Ir = 10.6+ 1i*425;Pt = 9.6+ 1i*10.3;Au = 7.9+ 1i*0;Hg = 12.66+ 1i*372.3;Tl = 8.776+ 1i*3.43;Pb = 9.401+ 1i*0.171;Bi = 8.532+ 1i*0;Po = 0+ 1i*NaN;At = 0+ 1i*NaN;Rn = 0+ 1i*NaN;Fr = 0+ 1i*0;Ra = 10+ 1i*0;Ac = 0+ 1i*0;Th = 10.31+ 1i*7.37;Pa = 9.1+ 1i*200.6;U = 8.417+ 1i*7.57;Np = 10.55+ 1i*175.9;Pu = 0+ 1i*0;Am = 8.3+ 1i*0;Cm = 9.5+ 1i*0;
%D = 6.674+1i*0.000519;
%save('NeutronB.mat','H','D','He','Li','Be','B','C','N','O','F','Ne','Na','Mg','Al','Si','P','S','Cl','Ar','K','Ca','Sc','Ti','V','Cr','Mn','Fe','Co','Ni','Cu','Zn','Ga','Ge','As','Se','Br','Kr','Rb','Sr',...
%  'Y','Zr','Nb','Mo','Tc','Ru','Rh','Pd','Ag','Cd','In','Sn','Sb','Te','I','Xe','Cs','Ba','La','Ce','Pr','Nd','Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm','Yb','Lu','Hf','Ta','W','Re','Os','Ir','Pt',...
%  'Au','Hg','Tl','Pb','Bi','Po','At','Rn','Ac','Th','Pa','U','Np','Pu','Am','Cm');
load('XrayF.mat');
% H = 1.00794; He = 4.002602; Li = 6.941; Be = 9.012182; B = 10.811; C = 12.011; N = 14.00674;
% O = 15.9994; F = 18.9984032; Ne = 20.1797; Na = 22.989768; Mg = 24.305; Al = 26.981539; Si = 28.0855;
% P = 30.973762; S = 32.066; Cl = 35.4527; Ar = 39.948; K = 39.0983; Ca = 40.078; Sc = 44.95591;
% Ti = 47.88; V = 50.9415; Cr = 51.9961; Mn = 54.93805; Fe = 55.847; Co = 58.9332; Ni = 58.69;
% Cu = 63.546; Zn = 65.39; Ga = 69.723; Ge = 72.61; As = 74.92159; Se = 78.96; Br = 79.904; Kr = 83.8;
% Rb = 85.4678; Sr = 87.62; Y = 88.90585; Zr = 91.224; Nb = 92.90638; Mo = 95.94; Tc = 98.9063;
% Ru = 101.07; Rh = 102.9055; Pd = 106.42; Ag = 107.8682; Cd = 112.411; In = 114.82; Sn = 118.71;
% Sb = 121.75; Te = 127.6; I = 126.90447; Xe = 131.29; Cs = 132.90543; Ba = 137.327; La = 138.9055;
% Ce = 140.115; Pr = 140.90765; Nd = 144.24; Pm = 146.9151; Sm = 150.36; Eu = 151.965; Gd = 157.25;
% Tb = 158.92534; Dy = 162.5; Ho = 164.93032; Er = 167.26; Tm = 168.93421; Yb = 173.04; Lu = 174.967;
% Hf = 178.49; Ta = 180.9479; W = 183.85; Re = 186.207; Os = 190.2; Ir = 192.22; Pt = 195.08;
% Au = 196.96654; Hg = 200.59; Tl = 204.3833; Pb = 207.2; Bi = 208.98037; Po = 208.9824; At = 209.9871;
% Rn = 222.0176; Ac = 223.0197; Th = 226.0254; Pa = 227.0278; U = 232.0381; Np = 231.0359; Pu = 238.0289;
% Am = 237.0482; Cm = 244.0642; Bk = 243.0614; Cf = 247.0703; Es = 247.0703; Fm = 251.0796; Md = 252.0829;
% No = 257.0951; Lr = 258.0986; Rf = 259.1009; Db = 260.1053; Sg = 261.1087; Bh = 262.1138; Hs = 263.1182;
% Mt = 262.1229;
Nn	= 1;	%Nn = Not named - for not named substances

if substance(1) ~= '"',         % substance chemical formula (not a name)

substance_index = 0;
bracket_index = 0;
last_bracket = [];
substance_char(1).second = '';
substance_char(1).first = '';

while char_index < length(substance),
   char_index = char_index + 1;
   if (substance(char_index)>= 'A') & (substance(char_index)<= 'Z'),         
      substance_index = substance_index+1;												
      factor(substance_index) = 1;
      substance_mass(substance_index) = 0;
      substance_char(substance_index).first = substance(char_index);
   	number = 0;
   elseif (substance(char_index)>= 'a') & (substance(char_index)<= 'z'),		%small letter
      substance_char(substance_index).second = substance(char_index);
      number = 0;
   elseif (substance(char_index)>= '0') & (substance(char_index)<= '9'),		%number
      number = 1;
      chartype(char_index,:) = 'nu';											
      if chartype(char_index-1,:) == 'nu',
         factor(substance_index) = factor(substance_index)*10+str2num(substance(char_index));
      else%if 
         factor(substance_index) = str2num(substance(char_index));
      end%if
   elseif (substance(char_index)== '+')|(substance(char_index)== '-'),
      factor(substance_index) = 1;      
   elseif substance(char_index)== '(',
      substance_index = substance_index+1;
      bracket_level = 1;
      bracket_char_index = 0;
      while bracket_level > 0,
         char_index = char_index+1;
         bracket_char_index = bracket_char_index+1;
         if 		substance(char_index) == '(', bracket_level = bracket_level + 1;
         elseif	substance(char_index) == ')', bracket_level = bracket_level - 1;
         end%if
         if bracket_level > 0,
            bracket_substance(bracket_char_index) = substance(char_index);
         end%if
      end%while
      substance_char(substance_index).first = '('; 
      substance_mass(substance_index) = MolMass(bracket_substance);
      number = 0;
   end%if
end%while char_index

for ei = 1:substance_index,
   if substance_char(ei).first ~= '(',
      if isempty(substance_char(ei).second),
         substance_mass(ei) = eval(substance_char(ei).first);
   	else
      	substance_mass(ei) = eval([substance_char(ei).first;substance_char(ei).second]);
      end% if
   end%if 
end%for
MM = substance_mass*factor';

elseif any(substance=='('),         % substance is not a chemical formula but a name 
  for i = 2:length(substance),
      if substance(i) == '(',
          j = i+1; MM_str = '';
          while substance(j) ~= ')' & j <= length(substance),
             MM_str = [MM_str substance(j)];
             j = j+1;
          end % while
      MM = str2num(MM_str);
      end % if
  end % for
else
  MM = 1;
end % if substance(1) ~= '"',         % substance is not a chemical formula but a name 

end % if substance(1) == '[',		  % vector of substances

%end MolMass.m