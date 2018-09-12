echo "Begin Log: $(date '+%Y-%m-%d %H:%M:%S')" >> ./log.txt
mkdir "./CSV"
mkdir "./output"

# initialize variables
elapsed=0
dccount=0
dclength=0
pccount=0
pclength=0
paccount=0
numpac=0
bar=""
notbar="........................."
hits=0
misses=0


dcpack48=./dcname48/
dcpack20=./dcname20/
pcpacks=./pcname/

numpac=$(ls -1 ${dcpack20} | wc -l)


# keep track of time
start=$(date +%s%3N) 
for pacNam in `ls -v $dcpack20`; do 
	
	paccount=$(($paccount+1))
	
	mkdir "./output/$pacNam"
	
	dccount=0
	
	# info for progress bar
	dclength=$(ls -1 ${dcpack20}$pacNam/*.xma | wc -l)
	
	# create a progress bar	
	pctDone=$(( ($paccount * 100)/$numpac )) # use count to calculate percent done
	
	while [ $(( ${#bar} * 4)) -lt $pctDone ]; do # if bar * 4 is less than percent done, then bar max length is 25
		bar="$bar#"
		notbar=${notbar%?}
	done
	
	
	for a in `ls -v ${dcpack20}$pacNam/*.xma`; do
		
		# info for progress bar
		pccount=0
		pclength=$(ls -1 ${pcpacks}$pacNam/*.xma | wc -l)		
		dccount=$(($dccount+1)) # keep track of count
		
		
		cleana=${a##*/} # strip file path to use below
		cleana=${cleana%.*} # strip file extension to use below
		
		for b in `ls -v ${pcpacks}$pacNam/*.xma`; do
		
			# info for progress bar
			pccount=$((pccount+1))
			
			
			cleanb=${b##*/} # strip file path to use below
			
			
			# display progress
			echo "      $pctDone% [$bar$notbar] $paccount/$numpac $dccount/$dclength $pccount/$pclength      \r\c"
			
			
			
			if [ -z "$(cmp $a $b)" ]; then	# compare files and perform logic	
				
				mv "./rename/$pacNam/$cleana.wav" "./output/$pacNam/$cleanb"	
				echo "$cleana.wav,$cleanb" >> ./CSV/$pacNam.csv
				hits=$((hits+1))
				rm $a
				rm $b
				break
			fi		
			
			
			# if dcpack20 fails to find match, check dcpack48
			if [ -z "$(cmp ${dcpack48}$pacNam/$cleana.xma $b)" ]; then	# compare files and perform logic	
				
				mv "./rename/$pacNam/$cleana.wav" "./output/$pacNam/$cleanb"	
				echo "$cleana.wav,$cleanb" >> ./CSV/$pacNam.csv
				hits=$((hits+1))
				rm $a
				rm $b
				break
			fi	
			
			
			if [ $pccount -eq $pclength ]; then # if last file in pcname
				echo "$a" >> ./nomatch.txt
				misses=$((misses+1))
			fi
		
		done
		
	done
done
end=$(date +%s%3N)
elapsed=$(( $end - $start ))

echo "Done!"

echo "cmp: $elapsed Milliseconds" >> ./log.txt
echo "Hits: $hits - Misses: $misses" >> ./log.txt
echo "End of Log: $(date '+%Y-%m-%d %H:%M:%S')\n" >> ./log.txt
