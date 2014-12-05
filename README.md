PageRank
========
PageRank.m is a MatLab implementation of PageRank algorithm following the steps at
http://www.math.cornell.edu/~mec/Winter2009/RalucaRemus/Lecture3/lecture3.html

*uses Matlab's parallel (parfor for parallel for loops) computing toolbox to speed up implementation of matrices larger than 10,000 x 10,000

1. Download and copy PageRank.m into working directory in matlab
2. open matlab
3. type command --> [rank100, rankValues, eigenvector, k]=PageRank(FilePath,alpha)<br>
  -rank100 returns up to the top 100 nodes<br>
  -rankValues returns the corresponding value of from the eigenvector of the top 100 nodes<br>
  -eigenvector shows the complete eigenvector<br>
  -k returns the number iterations to reach convergence<br>

  -FilePath is the file path surrounded by single quotes to the sparse adjacency matrix file<br>
  -alpha is the alpha value used to dampening (assignment says dampening factor .85=(1-alpha) so alpha=.15)
  <br>
  
To run the test matrix assigned
files needed:<br>
-PageRank.m<br>
-graph.txt<br>
1. re-define the graph given into a sparse matrix where columns i j k are ordered as "from i to j with the value of k"<br>
2. save the matrix as a text file. Because Matlab is numeric, here is the legend for what I used:<br> 
		a=1<br>
		b=2<br>
		c=3<br>
		d=4<br>
		e=5<br>
    You can use graph.txt in this repository as well<br>
3. Ensure that PageRank.m is in the workspace of matlab, to simplify, bring graph.txt into workspace as well<br>
4. in the command window type "[rank100, rankValues, eigenvector, k]=PageRank('graph.txt', .15)" <br>
5. the results should be as follows<br>
EDU>> [rank100,rankValues,eigenvector,k]=PageRank('graph.txt',.15)

rank100 =

     2
     5
     3
     4
     6
     1


rankValues =

  1.0e-321 *

    0.9851
    0.9604
    0.9109
    0.9109
    0.3366
    0.1139


eigenvector =

  1.0e-321 *

    0.1139
    0.9851
    0.9109
    0.9109
    0.9604
    0.3366


k =

       10621

EDU>> 

Looking at the results the rank looks like
<table>
	<tr>
		<td>
			node
		</td>
		<td>
			corresponding number
		</td>
		<td>
			value
		</td>
	</tr>
	<tr>
		<td>
			B
		</td>
		<td>
			2
		</td>
		<td>
			0.9851 e-321
		</td>
	</tr>
	<tr>
		<td>
			E
		</td>
		<td>
			5
		</td>
		<td>
			0.9604 e-321
		</td>
	</tr>	
	<tr>
		<td>
			C
		</td>
		<td>
			3
		</td>
		<td>
			0.9109 e-321
		</td>
	</tr>
	<tr>
		<td>
			D
		</td>
		<td>
			4
		</td>
		<td>
			0.9109 e-321
		</td>
	</tr>	<tr>
		<td>
			F
		</td>
		<td>
			6
		</td>
		<td>
			0.3366 e-321
		</td>
	</tr>	<tr>
		<td>
			A
		</td>
		<td>
			1
		</td>
		<td>
			0.1139 e-321
		</td>
	</tr>
</table>
