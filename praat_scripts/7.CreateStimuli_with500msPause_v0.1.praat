#==========================================================================================================================
# Creating the nov_learn stimuli (by combining two carrier phrases and adding a 500ms pause in between)
# (written by Rachel Tsui; 01/26/2021)
#
# Before running this script:
#	1. Normalize the intensity of the selected tokens and 
#		pull all the normed sound files in the "Intensity_Normed" folder 
#	2. Make the stimuli list named "list.csv": 1st row = output file name, each column lists the order of the soundfiles
#	3. Put the "list.csv" in the directory
#	4. Create a "Output" folder (this is where the 15s stimuli will be saved)
#	5. Determine the duration of pause to be added in between sentences
#	
# Running this script:
#	1. The output will be the combined stimuli (with pause in between each)
#==========================================================================================================================

#---------
##Clear
#---------
clearinfo

#------------------------
##Set working directory
#------------------------
form CreatingStimuli
	sentence curdir /Users/racheltsui/Documents/GitHub
	sentence sounddir 5.ALR_intensity_normalized
	sentence outputdir 6a.ALR_learning
	comment Please set the duration of pause (sec)
	positive pause_duration 0.5
endform

if endsWith(curdir$, "/") != 1
	curdir$ = curdir$ + "/"
endif

if endsWith(sounddir$, "/") != 1
	sounddir$ = sounddir$ + "/"
endif

if endsWith(outputdir$, "/") != 1
	outputdir$ = outputdir$ + "/"
endif

#---------------------------------------------
##Getting the .wav files from the sounddir
#---------------------------------------------

list$ = "list.csv"
listName$ = replace$(list$, ".csv", "", 0)  

Read Table from comma-separated file... 'curdir$''list$'

  select Table list
  stimN = Get number of columns
  fileN = Get number of rows

  for i from 1 to stimN
  select Table list
	stimSet$ = Get column label... 'i'
	
	for j from 1 to fileN
		select Table list

		file$ = Get value... 'j' 'stimSet$'
		fileName$ = replace$(file$, ".wav", "", 0)

  		Read from file... 'curdir$''sounddir$''file$'
		
		#-------------------------------------------------
		##Adding silence to the end of the soundd file
		#-------------------------------------------------
		Create Sound from formula: "silence", 1, 0, pause_duration, 44100, "0"
	
	endfor

#-------------------
##Conacatenation
#-------------------
	select all
	minus Table list
	Concatenate

#------------------------------------------
##Creating output and save to outputdir
#------------------------------------------
	selectObject: "Sound chain"
	new_duration = Get total duration
	save_duration = new_duration - pause_duration
	Extract part: 0, save_duration, "rectangular", 1, "no"
	
	Save as WAV file: curdir$ + outputdir$ + stimSet$ + ".wav"
	print 'stimSet$' FINISH!!!	
	select all
	minus Table list
	Remove

endfor

select all
Remove

