#====================================================================================================
# Duration analysis
# (written by Rachel K.Y. Tsui, 12/14/2020)
#
# # Before running this script:
#	1. Put all the sound files in one folder
#
# Running this script:
#	Extract duration information from the sound files
#====================================================================================================

#---------
##Clear
#---------
clearinfo

#-------------------------
##Set working directory
#-------------------------
form Extract raw duration info
	comment Put all the sound files in the "readFrom" folder
	sentence readFrom /Users/racheltsui/Desktop/discrimination/English_44100
	sentence saveTo /Users/racheltsui/Desktop/discrimination/
endform

if endsWith(readFrom$, "/") != 1
	readFrom$ = readFrom$ + "/"
endif


#---------------------------------------------------------------------------
# create table to record the duration of the raw audio files
#---------------------------------------------------------------------------
raw_values = Create Table with column names: "Raw_Values", 1, "File Duration" 

#-----------------------------------------
# get files in the to read directory
#-----------------------------------------
string = Create Strings as file list: "files", readFrom$ + "/*.wav"
numberOfSounds = Get number of strings
for i to numberOfSounds
	select string
	file$ = Get string: i
	file'i'$ = file$
	file'i' = Read from file: readFrom$ + file$
	syllableDuration'i' = Get total duration
	select raw_values
	Set string value: i, "File", file$
	Set numeric value: i, "Duration", syllableDuration'i'

	select raw_values
		if (i < numberOfSounds)
			Append row
		endif
endfor

#-----------------------------------------
# save the table as a text file
#-----------------------------------------
Save as comma-separated file: saveTo$ + "Raw_Duration_Table.csv"

#------------------------------------
# Finish & Clean up
#------------------------------------
select all 
Remove

echo Done!

