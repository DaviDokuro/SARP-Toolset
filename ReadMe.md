# SARP ReadMe!

Link to release thread: https://www.shenmuedojo.com/forum/index.php?threads/release-shenmue-audio-restoration-project-v1-003.593/	

Thank you for choosing PCDC tools for all your Shenmue audio needs. 

### In this ReadMe, we'll be going over:

	# Using the shenMove.sh script to: 
		-rename individual packs from CSV records
		
	# Using the shenMoveAll.sh script to: 
		-rename all packs from CSV records
	
	# Using the pcmc.sh script to 
		-rename individual packs through comparison algorithm 
		-generate csv record of changes made

	# Using the pcmcAll.sh script to 
		-rename all packs through comparison algorithm 
		-generate csv record of changes made

### Bonus Files:

	massconv.cmd
We modified massconv.cmd from the ADPCM toolkit. 
This version will let you convert multiple packs of .str files to .wav with one script. 
Just place all of the .srt files in their original folders in the "input" folder, and magically they will appear in the output folder.
This will be useful to everyone using any of the tools included.

	Batch xWMA.cmd 
Based on the script for massconv.cmd, we wrote a script to convert to .xma.
This script requires the xwmaencode exe to be in the same folder with it. 
It will output .xma files in both 20k and 48k sample rates.
This will only be useful to people using pcdc.sh or pcdcAll.sh.

### To use shenMove.sh:
	
First, you will need to create a working directory with shenMove.sh file and the "CSV" folder containing the CSV records.
You will also need to create a folder titled "rename" to use later.

	/rename/
	/CSV/
	shenMove.sh

To begin the process of conversion, download the Shenmue Translation Pack as well as the SelfBoot Data Pack (links provided below).
Use the SelfBoot Data Pack to extract your GDI dumps of Shenmue, afsutils to extract the .afs archives in scene/01/stream/, 
and the ADPCM Streaming Toolkit to convert the .STR files extracted from the .afs archives to .wav files.
More detailed instructions can be found on the Shenmue Translation Pack website.

http://shenmuesubs.sourceforge.net/download/addons/Selfboot_DATA_Pack_v1.4_by_FamilyGuy.rar	
http://shenmuesubs.sourceforge.net/download/


After you have converted the .STR files to .WAV, place them in the "rename" folder. 

The script takes two arguments, the disk number and the name of the pack you are renaming. 
Running the script would look like this, where 01 is the disk number and FREE01 is the pack name:

	sh shenMove.sh 01 FREE01

Running this code will use the FREE01.csv in the "CSV/01" folder to rename all of the WAV files in the "rename" folder. 



### To use shenMoveAll.sh:

shenMoveAll.sh is similar to shenMove.sh in it's operation. 
However, rather than giving it two arguments, you only tell it which disk you are renaming.
It will traverse the file tree automatically to rename everything.

	(This guide assumes you have already converted the Dreamcast .STR files to .WAV as per the instructions above)

Setup is simple. First start by building the same working directory as for the previous script:

	/rename/
	/CSV/
	shenMoveAll.sh

When you have the folders set up, it's time to start preparing the data, and this is where the difference is. 
Instead of dropping the WAV files from one pack directly into the "rename" folder, you will be putting the WAVs in "rename" in their respective folders.
The WAVs must be contained directly in folders which retain the original pack name, eg 01BEDA, 01BEDB, 01BUS etc

Once that is taken care of, simply run shenMoveAll.sh with the disk number as an argument:

	sh shenMoveAll.sh 01

When shenMoveAll.sh runs, it will look at the folder names in the rename directory. 
It will then use that folder name to look up the associated CSV for the designated disk.
Last, it will use that CSV to rename all of the files in that folder, before moving on to the next folder.

You can put as many or as few folders in the rename directory as you want, it will only poll the CSV files associated with the folders in "rename".



### To use pcdc.sh:
	
...ok, this one's complicated. Hear me out. You do not need to use this just to rename the files. 
This script is more important for generating the CSV files. It is very time consuming and way more involved than the previous scripts.
If you still want to use pcdc.sh, carry on reading.
NOTE: By the time the code finishes, there will only be the renamed files in the "output" folder. All other files will be lost.
If you want to save the files, you will need to copy them BEFORE running the script.

	(This guide assumes you have already converted the Dreamcast .STR files to .WAV as per the instructions above)


The way pcdc.sh works is by doing a byte-by-byte comparison of the files given to it. 
Since we are able to generate identical XMA files, we are able to compare those files to quickly associate DC names with PC names.


First, create a working directory with the following folders:

	/dcname/
	/pcname/
	/rename/
	/output/
	pcdc.sh

To generate the XMA files:

	# Dewey will explain when he fully understands

When your files are ready to go:

	# put the XMA files which still retain their DC names in the "dcname" folder.
	# put the XMA files from the PC version in the "pcname" folder.
	# put the WAV files you converted from the original DC files in the "rename" folder

Once all that is in place, you're ready to go!
pcdc.sh takes no arguments, runing the script is just:

	sh pcdc.sh

The code will take a while to run for larger packs.
Converting FREE01 takes about half an hour, but it is also one of the largest packs.
Most packs contain only 10 files or so, where FREE01 contains over 12000.
NOTE: Bash for Windows is much slower and takes about 6-7 hours for this same task. 
		Msys2 was so slow I couldn't even time it.

After the code has completed running, you may have a few files that were missed. This is because of bitrates.
You can use the files left in the "rename" folder to generate new XMA files with different bitrates to test again.
Repeat until there are only files left in the output folder.

The script runs in O(N) time in the best case (100% file matches)	
but will run in O(N Squared) time in the worst case (0% matches)

If the script is running for over 4 hours, call your doctor.


	
### To use pcdcAll.sh:

	If you plan on running this script, I'm sure you can figure it out.
	If you can't figure it out, then you don't need to.
	
	Just a side note, to convert all of disk 1 requires the preparation of ~60k files with this script. 
	So yea, you don't wanna put yourself through that. 
	Take the easy way out and check out shenMoveAll instead.
	You would only need to prepare ~15k files and the runtime will be considerably lower.
	Please, everyones worried about you. You don't need to do this.
	
	
