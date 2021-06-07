#====================================================================================
# Adding silence to the beginning of each .wav file in a directory
# (written by Rachel Tsui; last update: 20210119)
#
# Before running this script:
#	1. Manually extract the tokens from the original sound file
# 	2. Save all the extracted token into a new file
# Running this script:
#	- Adding a specific duration of silence to each of .wav file in your directory
#	- You can choose how many sec. (the duration of silence) to add
#====================================================================================

#---------
##Clear
#---------
clearinfo

#------------------------
##Set working directory
#------------------------
form Get Add Silence to Beginning
	sentence directory /Users/racheltsui/Documents/GitHub/sound/
	sentence save_to /Users/racheltsui/Documents/GitHub/output/
	positive silence_duration 0.2
endform

if endsWith(directory$, "/") != 1
	directory$ = directory$ + "/"
endif

if endsWith(save_to$, "/") != 1
	save_to$ = save_to$ + "/"
endif

#----------------------------------------------
##Get all the .wav from the working directory
#----------------------------------------------
filelist = Create Strings as file list: "filelist", directory$ + "*.wav"
nOfFiles = Get number of strings
for i to nOfFiles
	silenceWav = Create Sound from formula: "silence", 1, 0, silence_duration, 44100, "0"
	selectObject: filelist
	filename$ = Get string: i
	basename$ = filename$ - ".wav"
	currentWav = Read from file: directory$ + filename$

	#-----------------------------------------------
	##Create silence and add it to the .wav file
	#-----------------------------------------------
	selectObject: silenceWav, currentWav
	Concatenate
	selectObject: "Sound chain"
	Save as WAV file: save_to$ + basename$ + "_silence.wav"

endfor

select all
Remove

echo DONE!!!
