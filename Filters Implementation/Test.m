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

%-- implement the filter in time domain --

input = [ 0 1 2 3 ]
%define x_0 to be the input
x_1 = 0;
x_2 = 0;
y_1 = 0;
y_2 = 0;
y_3 = 0;
y_out = [];

for i = 1:1:length(input)

  x_0 = input(i);

  y_0 = b(1)*x_0 + b(2)*x_1 + b(3)*x_2 + a(1)*y_1 + a(2)*y_2 + a(3)*y_3;

  y_out = [y_out y_0];

  y_1 = y_0;
  y_2 = y_1;
  y_3 = y_2;

end

y_out = y_out
%printf("\noutput %d %d %d %d \n", y_out);

%tesing upsample
z = [1 2 3]
z_up = upsample(z,6)
