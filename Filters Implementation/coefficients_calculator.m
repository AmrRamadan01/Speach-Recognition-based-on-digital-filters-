%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
% Calculates the coefficents of the digital filters to be used in the  %
% main program.     [TESTING]                                          %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-- define macros --
flt_ord = 2;
att_db = 20;    %dB
fs = 4000;      %Hz

%-- dfine cut-off frequencies --
fc_0 = 700;     %Hz

f_naq = fs/2;   %Hz

%-- calculate coefficients --
#{
   Generate a Chebyshev type II filter with RS dB of stopband
   attenuation.

   [documentation goes here]
#}

%-- second order low pass filter --
[b, a]=cheby2 (flt_ord, att_db, fc_0 / f_naq);


%-- display coefficients --
printf("\n[b] coefficients: \n");

for i = 1:1:length(b)
  printf("\nb[%d]= %d \n", i, b(i));
end

printf("\n[a] coefficients: \n");

for i = 1:1:length(a)
  printf("\na[%d]= %d \n", i, a(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
