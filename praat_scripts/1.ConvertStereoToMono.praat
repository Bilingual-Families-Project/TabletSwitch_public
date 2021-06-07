#====================================================================================
# Converting from Stereo to Mono
# (written by Rachel Tsui; 06/08/2020)
#
# Before running this script:
#	1. Convert all sound files to .wav
#	2. Pull all the original sound files in the "stereo" folder 
#	3. Create a "mono" folder (this is where the converted files will be saved)
#	
# Running this script:
#	1. Can be ran on multiple sound files at the same time
#	(as long as all sound files are in the "original" folder)
#	2. Convert all stereo files to mono
#====================================================================================

#---------
##Clear
#---------
clearinfo

#-------------------------
##Set working directory
#-------------------------

form ConvertStereoToMono
	comment Set your directories here:
	sentence readFrom /Users/rachelkytsui/Desktop/NIH Praat script/Stereo/
	sentence saveTo /Users/rachelkytsui/Desktop/NIH Praat script/Mono/
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
	Convert to mono
	Save as WAV file: saveTo$ + basename$ + ".wav"

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

select all
Remove