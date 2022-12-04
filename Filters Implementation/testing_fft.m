%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%            Tests the use fft in fingerprint generation               %
%                          [TESTING PHASE]                             %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-- get the song samples (song), sampling rate (FS), and song length (len) --
audio_path = 'G:\Education ENG\ENG Level #3\Embedded\Projects\Speech Recognition\Filters Implementation\Sound_2_(handfree).wav';
[song , FS] = audioread (audio_path) ;
len = length(song);

%-- play the audio file --
fprintf('The Song is playing...\n')
sound(song,FS);
pause(len/FS);

%-- convert the song into mono-channel --
song = song(:,1);

%-- transorm to frequency domain --
songFrequencyDomian = fft(song);

%-- divide by len to adjust the mag spectrum --
songMag = abs(songFrequencyDomian / len) ;



%%%%%%%%%%%%%%%%%%%%%%% FUll Length Spectrum %%%%%%%%%%%%%%%%%%%%%%%%%%

%-- construct the single-sided spectrum --
singleMag = songMag(1:len/2+1);
singleMag(2:end-1) = 2*singleMag(2:end-1);


%-- plot the single-sided spectrum --
Fdom1 = FS*(0:(len/2))/len;
figure
subplot(2,1,1);
plot (Fdom1, singleMag,'b') ; title('full frequency Spectrum');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%% 2K-Length Spectrum %%%%%%%%%%%%%%%%%%%%%%%%%%%

%-- construct the 2K single-sided spectrum --
singleMag = songMag(1:len/2+1);
singleMag(2:end-1) = 2*singleMag(2:end-1);
singleMag([3000:end]) = 0;

%-- plot the 2K single-sided spectrum --
Fdom2 = FS*(0:(len/2))/len;
subplot(2,1,2);
plot (Fdom2, singleMag,'b') ; title('2K frequency Spectrum');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%% Sampling Frequency Vector %%%%%%%%%%%%%%%%%%%%%%

%-- sampling frequency vector --
sfv = [];
numOfSam = 100;
len = length(singleMag);
spacing = floor(len / numOfSam);
window = 100;

for i = 0:1:(numOfSam-1)
  %get 10 samples at different frequincies

  sample = 0;
  for j = 1:1:window
    sample = sample + singleMag([(i*spacing)+j]);
  end

  sfv = ([sfv sample]);
end

%-- base vector (x-axis) --
#let it be equal to Fdom2 for now.
#Which is the same x-axis as the 2K plot
#to be easliy compared to the 2K spectrum.
sfv_base = Fdom2;

sfv = sfv';
sfv = upsample(sfv, ceil(length(sfv_base)-length(sfv))/numOfSam+1);


%-- plot the SFV spectrum --
figure
plot (sfv_base, sfv, 'b') ; title('SFV Spectrum');

%-- change the name to be used conviently later in the code --
templateFingerPrint = sfv;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%% Load Input Sample %%%%%%%%%%%%%%%%%%%%%%%%%%

%-- read audio file using windows file manager --
fprintf('browse for the input sample (.wav) you want to check\n');

%-- browse for wav files and get file nanme and path
[file,path] = uigetfile('*.wav');

%-- combine the path and file name in one line
fname = fullfile(path,file);

%-- get the input samples (inSample), sampling rate (FS), and song length (len) --
[inSample , FS] = audioread (fname) ;
len = length(song);

%-- play the audio file --
fprintf('The input sample is playing...\n')
sound(inSample,FS);
pause(len/FS);

%-- convert the input sample into mono-channel --
inSample = inSample(:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%% Get Input Finger Print %%%%%%%%%%%%%%%%%%%%%%%%


%----------------------- FUll Length Spectrum -------------------------%

%-- transorm to frequency domain --
inFrequencyDomain = fft(inSample);

%-- divide by len to adjust the mag spectrum --
inSampleMag = abs(inFrequencyDomain / len) ;

%-- construct the single-sided spectrum --
inSingleMag = inSampleMag(1:len/2+1);
inSingleMag(2:end-1) = 2*inSingleMag(2:end-1);


%-- plot the single-sided spectrum --
inFdom1 = FS*(0:(len/2))/len;
figure
subplot(2,1,1);
plot (inFdom1, inSingleMag,'g') ; title('Input full frequency Spectrum');



%------------------------ 2K-Length Spectrum --------------------------%

%-- construct the 2K single-sided spectrum --
inSingleMag = inSampleMag(1:len/2+1);
inSingleMag(2:end-1) = 2*inSingleMag(2:end-1);
inSingleMag([3000:end]) = 0;

%-- plot the 2K single-sided spectrum --
inFdom12 = FS*(0:(len/2))/len;
subplot(2,1,2);
plot (inFdom12, inSingleMag,'g') ; title('Input 2K frequency spectrum');




%---------------------- Sampling Frequency Vector ---------------------%

%-- sampling frequency vector --
inSFV = [];
len = length(inSingleMag);


for i = 0:1:(numOfSam-1)
  %get 10 samples at different frequincies

  sample = 0;
  for j = 1:1:window
    sample = sample + inSingleMag([(i*spacing)+j]);
  end

  inSFV = ([inSFV sample]);
end

%-- base vector (x-axis) --
#let it be equal to inFdom12 for now.
#Which is the same x-axis as the 2K plot
#to be easliy compared to the 2K spectrum.
inSFV_base = inFdom12;

inSFV = inSFV';
inSFV = upsample(inSFV, ceil(length(inSFV_base)-length(inSFV))/numOfSam+1);


%-- plot the inSFV spectrum --
figure
plot (inSFV_base, inSFV, 'g') ; title('inSFV Spectrum');

%-- change the name to be used conviently later in the code --
inFingerPrint = inSFV;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%% Compare Input Smaple To Template Fingerprint %%%%%%%%%%%%%%

disp("Matching with template...");

%-- cross corelation --
crossCor = xcorr(templateFingerPrint, inFingerPrint);

%-- pesudo eculidian norm --
eucNorm = abs(inFingerPrint - templateFingerPrint);

%-- sum of cross corelation --
corrSum = sum(crossCor);

if(corrSum >= 2 )
  disp("Match detected!");

else
  disp("No template matches the input signal!");
end



