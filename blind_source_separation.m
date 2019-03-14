%{
Blind Source Separation using FastICA algorithm.

The goal of BSS is to pull out 'n' seperated records from 'n' mixed
records. The problem is known as 'Coctail Party'.
This example is done for n = 3.

inputs:
    mix1 --> 1st mix of first, second and third record with selected
             amplitude coefficients a1, a2, a3

    mix2 --> 2nd mix of first, second and third record with selected
             amplitude coefficients b1, b2, b3

    mix3 --> 3rd mix of first, second and third record with selected
             amplitude coefficients c1, c2, c3

outputs:
    sep_audio1 --> Seperated first track
    sep_audio2 --> Seperated second track
    sep_audio3 --> Seperated third track

audio_1 --> 1st original record (only first channel)
audio_2 ---> 2nd original record (only first channel)
audio_3 ---> 3rd original record (only first channel)

audio_mix(1, :) --> 1st mixed record
audio_mix(2, :) --> 2nd mixed record
audio_mix(3, :) --> 3rd mixed record

a1, a2, a3, b1, b2, b3, c1, c2, c3 --> amplitude coefficients in mixed records
fs = 44100 Hz --> Sampling rate
%}

clear, clc;

a1 = 0.5; a2 = 0.9;  a3 = 0.1;
b1 = 0.8; b2 = 0.05; b3 = 0.3;
c1 = 0.2; c2 = 0.45; c3 = 0.7;

[x, fs] = audioread('audio1.wav');       
audio_1 = x(:, 1);                             

[y] = audioread('audio2.wav');                   
audio_2 = y(:, 1); 

[z] = audioread('audio3.wav');              
audio_3 = z(:, 1);                              

t = min([length(audio_1), length(audio_2), length(audio_3)]);

audio_1 = audio_1(1:t);
audio_2 = audio_2(1:t);
audio_3 = audio_3(1:t);

audio_mix = zeros(3, t);
audio_mix(1, :) = a1*audio_1 + a2*audio_2 + a3*audio_3;
audio_mix(2, :) = b1*audio_1 + b2*audio_2 + b3*audio_3;
audio_mix(3, :) = c1*audio_1 + c2*audio_2 + c3*audio_3; 

mix1 = audioplayer(audio_mix(1,:), fs);
mix2 = audioplayer(audio_mix(2,:), fs);
mix3 = audioplayer(audio_mix(3,:), fs);

%1.
audio_mix(1, :) = audio_mix(1, :) - mean(audio_mix(1, :));
audio_mix(2, :) = audio_mix(2, :) - mean(audio_mix(2, :));
audio_mix(3, :) = audio_mix(3, :) - mean(audio_mix(3, :));

%2. 
V = zeros(3,3);
P = zeros(3, t);

for i=1:t
    V = V + (audio_mix(:, i)*audio_mix(:, i)');
end
V = V/t;
V = V^(-1/2);

for i=1:t
    P(:, i) = V * audio_mix(:, i);
end

%3.
w = [rand(), rand(), rand()];
flaga = true;
VecW = zeros(3, 1);

%4.
for i=1:3
    flaga = true;
    while flaga
        w0 = w;
        sum = 0;
        for j=1:t
            a = P(:, j)'*((w*P(:, j))^3);
            sum = sum + a;
        end
        sum = sum/t;
        w = sum - 3*w;

        w = w'-VecW*VecW'*w';
        w = w';
        w = w/norm(w);

        if abs(w0*w' - 1) < 0.0001
            flaga = false;
        end
    end
    VecW(:, i) = w';
end

S = VecW'*P;

audio_1 = S(1, :);
audio_2 = S(2, :);
audio_3 = S(3, :);

sep_audio1 = audioplayer(audio_1, fs);
sep_audio2 = audioplayer(audio_2, fs);
sep_audio3 = audioplayer(audio_3, fs);







