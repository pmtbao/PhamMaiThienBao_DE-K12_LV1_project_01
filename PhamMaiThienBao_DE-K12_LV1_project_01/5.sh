# 5.Top 10 bộ phim đem về lợi nhuận cao nhất: 
mlr --icsv --opprint put '$profit=$revenue-$budget' then top -f profit -a -n 10 tmdb-movies.csv | less -S
