while read p; do
	mv ./rename/${p%,*} ./rename/${p#*,}
done <./CSV/$1.csv
