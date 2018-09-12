filepath="./rename/"

# Progress Stats
numpacks=$(find $filepath* -maxdepth 0 -type d | wc -l)
packcount=0

for f in $filepath*; do
	
	pacNam=${f##*/}
	
	# Progress Stats
	packcount=$((packcount+1))	
	csvcount=0
	csvlines=$(wc -l < ./CSV/$pacNam.csv)
	
	while read p; do
		csvcount=$((csvcount+1))
		
		dcname=${p%,*} # Parse CSV line
		pcname=${p#*,}
		
		mv "${filepath}${pacNam}/${dcname}" "${filepath}${pacNam}/${pcname}"
		
		# Display Progress
		echo "      Pack: $packcount/$numpacks File: $csvcount/$csvlines $pacNam      \r\c"
	done <./CSV/$pacNam.csv
	
done
	
echo "Done!"
