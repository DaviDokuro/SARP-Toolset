echo "Begin Log: $(date '+%Y-%m-%d %H:%M:%S')" >> ./log.txt

# initialize variables
elapsed=0
compcount=0
dclength=0
pclength=0
bIter=0
bar=""
notbar="........................."
hits=0
misses=0

dcnames=./dcname/*
pcnames=./pcname/*
# print out all dreamcast names
#echo "DC Names:" $dcnames >> ./log.txt
# print out all pc names
#echo "PC Names:" $pcnames >> ./log.txt


#operations for progress bar
dclength=$(ls -1 ${dcnames} | wc -l)
pclength=$(ls -1 ${pcnames} | wc -l)

echo "Number of DC Files: $dclength" >> ./log.txt
echo "Number of PC Files: $pclength" >> ./log.txt

# keep track of time
start=$(date +%s%3N) 
for a in `ls -v $dcnames`; do 
	bIter=0
	pclength=$(ls -1 ${pcnames} | wc -l)
	
	# create a progress bar
	compcount=$(($compcount+1)) # keep track of count
	pctDone=$(( ($compcount * 100)/$dclength )) # use count to calculate percent done
	
	while [ $(( ${#bar} * 4)) -lt $pctDone ]; do # if bar * 4 is less than percent done, then bar max length is 25
		bar="$bar#"
		notbar=${notbar%?}
	done
	
	
	for b in `ls -v $pcnames`; do		
		bIter=$((bIter+1))
		
		# display progress
		echo "      $pctDone% [$bar$notbar] $compcount/$dclength $bIter/$pclength      \r\c"
		
		if [ -z "$(cmp $a $b)" ]; then	# compare files and perform logic	
			
			cleana=${a##*/} # strip file path to use below
			cleanb=${b##*/}
			cleana=${cleana%.*} # strip file extension to use below
			
			mv "./rename/$cleana.wav" "./output/$cleanb"	
			echo "$cleana.wav,$cleanb" >> ./log.csv
			hits=$((hits+1))
			rm $a
			rm $b
			break
		fi	
		if [ $bIter -eq $pclength ]; then # if last file in pcname
			#echo "$a found no matches" >> ./log.txt
			misses=$((misses+1))
		fi
	
	done
done
end=$(date +%s%3N)
elapsed=$(( $end - $start ))

echo "cmp: $elapsed Milliseconds" >> ./log.txt
echo "Hits: $hits - Misses: $misses" >> ./log.txt
echo "End Of Log: $(date '+%Y-%m-%d %H:%M:%S')\n" >> ./log.txt

echo "Done!"
