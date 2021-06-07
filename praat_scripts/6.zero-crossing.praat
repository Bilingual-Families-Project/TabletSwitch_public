###############################################
#Download from http://user.keio.ac.jp/~kawahara/scripts/zerocrossing.praat
###############################################

#---------
##Clear
#---------
clearinfo

#-------------------------
##Set working directory
#-------------------------
form Zero-crossing
	comment (1) Put all the sound files in the "readFrom" folder
	comment (2) Create a new "saveTo" folder titled 'Output' 
	sentence readFrom /Users/racheltsui/Desktop/discrimination/3.Spanish_44100
	sentence saveTo /Users/racheltsui/Desktop/discrimination/4.Spanish_zero-crossing
endform

if endsWith(readFrom$, "/") != 1
	readFrom$ = readFrom$ + "/"
endif

if endsWith(saveTo$, "/") != 1
	saveTo$ = saveTo$ + "/"
endif


Create Strings as file list... list 'readFrom$'*.wav
numberOfFiles = Get number of strings

for ifile to numberOfFiles

	select Strings list
	fileName$ = Get string... ifile
	Read from file: readFrom$ + fileName$
	sound_name$ = selected$ ("Sound")

	 	select Sound 'sound_name$'
		dur = Get total duration
	  	Edit
		editor Sound 'sound_name$'
		Select... 0 dur
		Move start of selection to nearest zero crossing
		Move end of selection to nearest zero crossing
		Write selected sound to WAV file: saveTo$ + fileName$
		endeditor

	select all
	minus Strings list
	Remove

endfor

#--------------------
##Finish & clean up 
#--------------------

printline Finished!

select all
Remove