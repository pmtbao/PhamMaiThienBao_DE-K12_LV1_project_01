#!/bin/bash

mlr --icsv --opprint cut -f cast tmdb-movies.csv > cast.csv

IFS=$'\n'
arr_cast=( $(tail -n +2 cast.csv | cut -d ',' -f1) )

for cast in ${arr_cast[@]}
do
	IFS='|'
	tmp=( $cast )
	for i in ${tmp[@]}
	do
		casts+=($i)
	done
done


echo "cast" > cast-1.csv
for cast in ${casts[@]}:
do
	echo $cast
done >> cast-1.csv

sed -i -e 's/"/'\''/g' cast-1.csv
sed -i -e 's/-//g' cast-1.csv

mlr --icsv --opprint stats1 -a count -f cast -g cast  then top -f cast_count -a -n 10 cast-1.csv | less -S
unset casts
