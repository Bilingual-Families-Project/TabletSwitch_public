# Patterns of language switching and bilingual childrens word learning: An experiment across two communities
## Project overview
Bilingual Families Project's online study: Word learning task. 
*  In this task we are investigating 3- to 5-year-old bilingual children's learning of cross-language synonyms (i.e., translation equivalents) in immediate translated sentences versus single language sentences.
*  Bilingual children's word learning will be assessed with an online asynchronous experiment. The design uses repeated measures, with condition (*Immediate-translation* condition vs. *One-language-at-a-time* condition) as within-subjects factor. Children will be taught and tested on four novel word-object pairings; half of the pairings will occur in immediate translated sentences (i.e., *Immediate-translation* condition) and half will occur in single language sentences (i.e., *One-language-at-a-time* condition). The experiment will be divided in two blocks, blocked by condition with the block order counterbalanced across participants.

## Repository overview
This repository holds the experiment materials, data file, data analysis scripts, and supplemental materials for the project "Patterns of language switching and bilingual children's word learning: An experiment across two communities" (https://psyarxiv.com/hpwbr).

Current files include:

* `Analysis`: Data file and R markdown analysis scripts 
* `Experiment_demo`: Video demonstrations of the experiment, along with the jsPsych script to create the experiment demo program
* `Experiment_program`: Repository for the four different test orders (4 orders per site, so there are 8 versions in total)
* `Praat_script`: Praat scripts used to generate the audio stimuli for the experiment
* `Stimuli_audio`: Audio stimuli used
* `Stimuli_image`: Visual stimuli used

### analysis

* `paper`: This folder contains the rmarkdown analysis scripts to generate the manuscript and supplemental material. 
  + `TabletSwitch_paper.Rmd`: Analysis reported in the main paper
  + `TabletSwitch_supplemental.Rmd`: Analysis reported in the supplemental material

* `data_clean.csv`: This data file holds all the data from the French-English and Spanish-English bilingual children who participated in our experiment.

* `data_dictionary.html`: This data dictionary defined the data elements contained in our data set.

### experiment_demo
This folder contains video demostration of the experiment testing English-French word-learning performance in the _"English first, one-language-at-a-time first"_ condition.

[Click here to view the online demo](https://rachelkytsui.github.io/demo_Bilingual-Families-Project_TabletSwitch/) 

(Note that your browser window will go to fullscreen. Click Esc if you would like to leave fullscreen mode).

* `demo_program`: This subfolder holds the demo experiment program, which contains the stimuli as well as jsPsych script to run the prgram.

* `demo_videos`
  + `TabletSwitch_demo_full_en_ol.mp4`: This video demonstrates the entire procedure of the experiment.
  + `TabletSwitch_demo_immediate-translation.mp4`: This video shows only the procedure of the *immediate-translation* condition.
  + `TabletSwitch_demo_one-language-at-a-time.mp4`: This video shows only the procedure of the *one-language-at-a-time* condition.


### experiment_program
This folder holds the programs created for the experiment. There are four different test orders (4 orders per site, so there are 8 versions in total). Each individual subfolder contains the jsPsych script that generates the program.

* `English_French`
  + `en_ol`: _"English first, one-language-at-a-time first"_ condition
  + `en_it`: _"English first, immediate-translation first"_ condition
  + `fr_ol`: _"French first, one-language-at-a-time first"_ condition
  + `fr_it`: _"French first, immediate-translation first"_ condition
  
* `English_Spanish`
  + `en_ol`: _"English first, one-language-at-a-time first"_ condition
  + `en_it`: _"English first, immediate-translation first"_ condition
  + `fr_ol`: _"Spanish first, one-language-at-a-time first"_ condition
  + `fr_it`: _"Spanish first, immediate-translation first"_ condition

* `4TestOrders_PseudoRandom_ObjectsPositions.xlsx`: The pseudo-randomization list


### praat_script
Repository containing the **manual** and **praat scripts** used to generate the audio stimuli for the experiment.

* `0.ExtractDurationInfo_v0.1.praat`: This script extracts duration information from the sound files.
* `1.ConvertStereoToMono.praat`: This script converts all sound files to mono signal.
* `2.OverrideSamplingFreq_44100Hz.praat`: This script converts the sampling frequency of all sound files to 44100Hz.
* `3.SegmentFiles_v0.2.praat`: This script segments the sound files
and gives us an individual .wav file for each recorded sentence.
* `5.NormalizeIntensity_v0.1.praat`: This script normalizes the intensity of all the sound files to 65dB.
* `6.zero-crossing.praat`: This script adjusts the beginning and end of all sound files to the nearest zero-crossings.
* `7.CreateStimuli_with500msPause_v0.1.praat`: This script creates the novel learning audio stimuli (with a 500ms pause in
between sentences).
* `8.AddSilence_ToBeginning_v0.1.praat`: This script adds silence to the beginning of each audio stimulus.
* `manual_creating the stimuli using Praat scripts.pdf`: This manual explains the procedure of how to run the praat scripts to create the stimuli for the experiment.


### stimuli_audio
Repository containing the audio stimuli used in the experiment.
* `English_French`: The audio stimuli used in the English-French versions.
* `English_Spanish`: The audio stimuli used in the English-Spanish versions. 

### stimuli_image
Repository containing all the visual stimuli used in the experiment.
