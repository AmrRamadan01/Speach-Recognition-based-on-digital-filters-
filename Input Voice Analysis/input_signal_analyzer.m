%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
% Reads input from the file manager and plots both time and frequency  %
% domain representations of the input signal.                          %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%-- read audio file using windows file manager --
fprintf('browse for the audio you want to transmit\n');

%-- browse for mp3 files and get file nanme and path
[file,path] = uigetfile('*.wav');

%-- combine the path and file name in one line
fname = fullfile(path,file);

%-- get the song samples (song), sampling rate (FS), and song length (len) --
[song , FS] = audioread (fname) ;
len = length(song);

%-- play the audio file --
fprintf('The Song is playing...\n')
sound(song,FS);
pause(len/FS);

%-- convert the song into mono-channel --
song = song(:,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-- time domain plot --
timeAxis = linspace(0, len/FS , len) ;
figure;
subplot(2,1,1);
plot (timeAxis , song,'r'); xlabel('time(s)') ; title('song Time Domain Waveform');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-- frequency domain plot ---
Fdom1 = linspace(-FS/2 , FS/2 , len);
song_freq_domain = fft(song);

%-- shift the frequency domian to be centred at the zero mark --

%-- uncomment the following line for double-sided spectrum --
%song_freq_domain = fftshift(song_freq_domain);

%-- divide by len to adjust the mag spectrum --
song_mag = abs(song_freq_domain / len) ;

%-- construct the single-sided spectrum --
single_mag = song_mag(1:len/2+1);
single_mag(2:end-1) = 2*single_mag(2:end-1);

Fdom2 = FS*(0:(len/2))/len;

%%%%%%%%% (commented out as all I need is the +ve side) %%%%%%%%%%
%-- plot the double-sided mag spectrum --
%{
subplot(2,1,2);
plot (Fdom1, song_mag,'b') ; title('song frequency Spectrum');
%}

%-- plot the single-sided spectrum --
subplot(2,1,2);
plot (Fdom2, single_mag,'b') ; title('song frequency Spectrum');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
