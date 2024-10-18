## Đạo diễn có nhiều bộ phim nhất
#!/bin/bash

mlr --icsv --opprint cut -f director tmdb-movies.csv > director.csv

IFS=$'\n'
arr_director=( $(tail -n +2 director.csv | cut -d ',' -f1) )

for director in ${arr_director[@]}
do
        IFS='|'
        tmp=( $director )
        for i in ${tmp[@]}
        do
                directors+=($i)
        done
done


echo "director" > director-1.csv
for directorin ${directors[@]}:
do
        echo $director
done >> director-1.csv

sed -i -e 's/"/'\''/g' director-1.csv
sed -i -e 's/-//g' director-1.csv

mlr --icsv --opprint stats1 -a count -f id -g director then top -f director_count -a tmdb-movies.csv | less -S
unset casts
