# 1.Sắp xếp các bộ phim theo ngày phát hành giảm dần rồi lưu ra một file mới: 
csvsort -d ','  -c 'release_date'--date-format '%m/%d/%Y' -r tmdb-movies.csv > sorted-movies.csv
