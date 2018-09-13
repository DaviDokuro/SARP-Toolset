while read p; do
	mv ./rename/${p%,*} ./rename/${p#*,}
done <./CSV/0$1/$2.csv
