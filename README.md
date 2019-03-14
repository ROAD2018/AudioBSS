Blind source separation using FastICA algorithm

1. Project description

   Blind source seperation method is used to seperate original (source) signals from their mixtures.
   In my project I used 3 audio records. Next, I mixed them with freely selected amplitude coefficients to get 3 mixed signals. 
   Eventually, as an output of my script, I received 3 audio records. Each of them is deprived of two others. 
   To obtain my results I used FastICA (Fast Independent Component Analysis) algorithm.
   
2. Independent Component Analysis
	
   This method is used for mixed signals in which every subcomponents are:
   - non-Gaussian signals
   - statistically independent from each other

   The problem which is solved in that project is very often called "Coctail Party" problem. 
   It's about noisy room, in which people are talking. The goal is to pull out from that noise a speech of one, specific person.
   
   
3. How to use that script

   To use that project, just load 3 audio files in .wav format. You can freely set coefficients a, b and c to mix signals.
   As an output, you will have 3 new audio files, which are seperated source signals.