PageRank.m is a MatLab implementation of PageRank algorithm following the steps at
http://www.math.cornell.edu/~mec/Winter2009/RalucaRemus/Lecture3/lecture3.html

*uses Matlab's parallel (parfor for parallel for loops) computing toolbox to speed up implementation of matrices larger than 10,000 x 10,000

1. Download and copy PageRank.m into working directory in matlab
2. open matlab
3. type command [rank100, rankValues, eigenvector, k]=PageRank(FilePath,alpha)<br>
  -rank100 returns up to the top 100 nodes<br>
  -rankValues returns the corresponding value of from the eigenvector of the top 100 nodes<br>
  -eigenvector shows the complete eigenvector<br>
  -k returns the number iterations to reach convergence<br>

  -FilePath is the file path surrounded by single quotes to the sparse adjacency matrix file<br>
  -alpha is the alpha value used to dampening (assignment says dampening factor .85=(1-alpha) so alpha=.15)
========

Page Rank Assignment
