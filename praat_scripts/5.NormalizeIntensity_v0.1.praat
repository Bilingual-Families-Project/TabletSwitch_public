#====================================================================================================
# Normalize intensity & printing intensity to a Table
# (written by Rachel K.Y. Tsui, 05/27/2020)
#
# Before running this script:
#	1. Put all the sound files in one folder
#	2. Create a new folder titled 'Intensity_Normed' (this is where the normed stimuli will be saved to)
#
# Running this script:
#	- Scaling the peak & intensity of all the .wav file in the object list
#	- You can choose the peak/ intensity value
#====================================================================================================

#---------
##Clear
#---------
clearinfo

#-------------------------
##Set working directory
#-------------------------
form Normalize Intensity
	comment (1) Put all the sound files in the "readFrom" folder
	comment (2) Create a new "saveTo" folder titled 'Intensity_Normed' 
	sentence readFrom /Users/racheltsui/Documents/GitHub/ALR_instructions_44100Hz
	sentence saveTo /Users/racheltsui/Documents/GitHub/output
	comment Please set your desired values here:
	positive peak 0.80
	positive intensity 65
endform

if endsWith(readFrom$, "/") != 1
	readFrom$ = readFrom$ + "/"
endif

if endsWith(saveTo$, "/") != 1
	saveTo$ = saveTo$ + "/"
endif

#-----------------------------------------------------------------
##Create table with 0 rows (append row when adding information)
#-----------------------------------------------------------------
rowNo = 0
tableObject = Create Table with column names: "NormedIntensity_Table", 0, "Soundfile Raw_Intensity Normed_Intensity"

#----------------------------------------------
##Get all the .wav from the working directory
#----------------------------------------------
filelist = Create Strings as file list: "filelist", readFrom$ + "*.wav"
nOfSounds = Get number of strings
for i to nOfSounds
	selectObject: filelist
	filename$ = Get string: i
	basename$ = filename$ - ".wav"
	currentWav = Read from file: readFrom$ + filename$

	#-----------------------------------------------------------------
	##Scale the intensity level of all .wav files at the same time
	#-----------------------------------------------------------------
	selectObject: currentWav
	raw_Intensity = Get intensity (dB)
	Scale peak: peak
	Scale intensity: intensity
	selectObject: currentWav
	Save as WAV file: saveTo$ + basename$ + "_IntensityNormalized.wav"

	#-----------------------------------------------------------
	##Get measurements: intensity
	#-----------------------------------------------------------
	selectObject: currentWav
	normed_Intensity = Get intensity (dB)

	#---------------
	##Add to table
	#---------------
	selectObject: tableObject
	Append row
	rowNo = rowNo + 1
	Set string value: rowNo, "Soundfile", basename$
	Set numeric value: rowNo, "Raw_Intensity", raw_Intensity
	Set numeric value: rowNo, "Normed_Intensity", normed_Intensity

endfor

#-------------------
##View data table, Finish & clean up
#-------------------
selectObject: tableObject
View & Edit
Save as comma-separated file: saveTo$ + "NormedIntensity_Table.csv"

echo Done!

select all
minusObject: tableObject
Remove
