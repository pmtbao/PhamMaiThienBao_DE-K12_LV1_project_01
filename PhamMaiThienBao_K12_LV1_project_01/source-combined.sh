# 1.Sắp xếp các bộ phim theo ngày phát hành giảm dần rồi lưu ra một file mới: 
csvsort -d ','  -c 'release_date'--date-format '%m/%d/%Y' -r tmdb-movies.csv > sorted-movies.csv

# 2.Lọc ra các bộ phim có đánh giá trung bình trên 7.5 rồi lưu ra một file mới: 
mlr --csv filter '$vote_average > 7.5' tmdb-movies.csv > filtering-movies.csv

# 3.Tìm ra phim nào có doanh thu cao nhất và doanh thu thấp nhất:
##Max
mlr --icsv --opprint top -f revenue -a tmdb-movies.csv | less -S
##Min
mlr --icsv --opprint top --min -f revenue -a tmdb-movies.csv | less -S

# 4.Tính tổng doanh thu tất cả các bộ phim:
mlr --icsv --opprint stats1 -a sum -f revenue tmdb-movies.csv

# 5.Top 10 bộ phim đem về lợi nhuận cao nhất: 
mlr --icsv --opprint put '$profit=$revenue-$budget' then top -f profit -a -n 10 tmdb-movies.csv | less -S

# 6.Đạo diễn nào có nhiều bộ phim nhất và diễn viên nào đóng nhiều phim nhất: 
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

##-----------------------------------------------------------------------------
## Diễn viên đóng nhiều phim nhất
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

# 7.Thống kê số lượng phim theo các thể loại. Ví dụ có bao nhiêu phim thuộc thể loại Action, bao nhiêu thuộc thể loại Family, …. 
!/bin/bash

mlr --icsv --opprint cut -f genres tmdb-movies.csv > genres.csv

IFS=$'\n'
arr_genres=( $(tail -n +2 genres.csv | cut -d ',' -f1) )

for genre in ${arr_genres[@]}
do
        IFS='|'
        tmp=( $genre )
        for i in ${tmp[@]}
        do
                genres+=($i)
        done
done

echo "genres" > genres-1.csv
for genre in ${genres[@]}:
do
        echo $genre
done >> genres-1.csv

mlr --icsv --opprint stats1 -a count -f genres -g genres genres-1.csv | less -S
unset genres
