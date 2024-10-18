# 2.Lọc ra các bộ phim có đánh giá trung bình trên 7.5 rồi lưu ra một file mới: 
mlr --csv filter '$vote_average > 7.5' tmdb-movies.csv > filtering-movies.csv
