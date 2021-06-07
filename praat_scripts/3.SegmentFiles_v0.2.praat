#====================================================================================
# Segmenting sound files
# (written by Ricardo A. H. Bion, 02/05/2009;
#	edited by Ron Pomper, 05/28/2014;
#	modified by Rachel Tsui; 05/26/2020)
#
# Before running this script:
#	1. Convert all sound files to .wav
#	2. Pull all the original sound files in the "original" folder 
#	3. Create a "saveTo" folder (this is where the segmented files will be saved)
#	
# Running this script:
#	1. Can be ran on multiple sound files at the same time
#	(as long as all sound files are in the "original" folder)
#	2. Segment all original sound files into individual sentences
#	3. Save each as individual sound files in the "saveTo" folder
#====================================================================================

#---------
##Clear
#---------
clearinfo

#-------------------------
##Set working directory
#-------------------------

form SegmentingSounds
	comment Set your directories here:
	sentence readFrom /Users/rachelkytsui/Desktop/NIH Praat script/original/
	sentence saveTo /Users/rachelkytsui/Desktop/NIH Praat script/Segmented/
	comment Set your desired configuration here
	integer silence_threshold_dB -30
	positive min_silent_interval_duration_s 1
	positive min_sounding_interval_duration_s 0.1
endform

if endsWith(readFrom$, "/") != 1
	readFrom$ = readFrom$ + "/"
endif

if endsWith(saveTo$, "/") != 1
	saveTo$ = saveTo$ + "/"
endif

#----------------------------------------------
##Get all the .wav from the working directory
#----------------------------------------------

filelist = Create Strings as file list: "filelist", readFrom$ + "*.wav"
nOfFiles = Get number of strings
for i to nOfFiles
	selectObject: filelist
	filename$ = Get string: i
	basename$ = filename$ - ".wav"
	currentWav = Read from file: readFrom$ + filename$

	#-------------------------------------------------------
	##Extracts segments from currentWav where there is sound
	#-------------------------------------------------------

	selectObject: currentWav
	text = To TextGrid (silences): 100, 0, silence_threshold_dB, min_silent_interval_duration_s, min_sounding_interval_duration_s, "silent", "sentence"
	selectObject: text
	plusObject: currentWav
	Extract intervals where: 1, "no", "is equal to", "sentence"
	selectObject: text
	plusObject: currentWav
	
	Remove

	#------------------------------------------------------------
	##Saves these segments as .wav files in the folder "Segmented"
	#------------------------------------------------------------
	select all
	minusObject: filelist

	nOfSounds = numberOfSelected()
	for j to nOfSounds
		select Sound 'basename$'_sentence_'j'
		full_name$ = basename$ + "_sentence_" + string$(j)
		Save as WAV file: saveTo$ + full_name$ + ".wav"	
	endfor

	#----------------------------------------------------------------------
	##Remove all current working files and select the next sound file
	#----------------------------------------------------------------------
	select all
	minusObject: filelist
	Remove
	
endfor
	
#--------------------
##Finish & clean up 
#--------------------

printline Finished!
printline 'i' segmentations

select all
Remove




### note on To TextGrid (silences)...###
# 100 = minimum pitch (Hz), 
# 0 = time step (s), 
# -30 = silence threshhold (dB), 
# 0.8 (English); 1.0 (Spanish) = minimum silent interval duration, 
# 0.1 = minimum sounding interval duration
# silent = silent interval label
# sound = sounding interval label