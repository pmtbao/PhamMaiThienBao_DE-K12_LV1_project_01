# 3.Tìm ra phim nào có doanh thu cao nhất và doanh thu thấp nhất:
##Max
mlr --icsv --opprint top -f revenue -a tmdb-movies.csv | less -S
##Min
mlr --icsv --opprint top --min -f revenue -a tmdb-movies.csv | less -S
