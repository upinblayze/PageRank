function [rank,values,eigen,k]=PageRank(fileName,alpha)
% PageRank - implements the page rank algorithm
% [rank,values,eigen,k]=PageRank(fileName,factor)
% fileName=fileName of sparse matrix
% alpha=dampening factor of Page Brin: (1-alpha)*A+alpha*B
% rank returns a vector of up to 100 in in order of highest rank to lowest
% values returns the value of associated values of the ranks
% eigen returns the full eigenvecter
% k returns the number of iterations necessary to complete converge
TM=createTransitionMatrix(fileName);
%     [pk,prank]=pageRankVector(TM)
rank2=PageRanker(TM,alpha);
[k, eigen]=pageRankVector(rank2);
[v,r]=sort(eigen,'descend');
row=size(eigen);
mini=min(row,100);
values=v(1:mini,1);
rank=r(1:mini,1);

end


function TM = createTransitionMatrix( fileName )
% createTransitionMatrix - makes a transition matrix out of a sparse matrix
% from fileName
s=load(fileName);
M=spconvert(s);
[rows,cols]=size(M);
%     divide each row item by the number of edges in the row
counts=sum(spones(M),2);

parfor row=1:rows
    row
    if(counts(row,1)~=0)
        M(row,:)=M(row,:)/counts(row,1);
    end
end
M(isnan(M))=0;
TM=M';
end


function [k,rank]=pageRankVector(TM)
% pageRankVector - to compute the eigenvector using PageRank
% TM=transition matrix
% outputs the eigenvector and the number of iterations it needs to succeed

[length,width]=size(TM);

v=ones(width,1);
v=v/width;
k=1;
tmp=TM*v;
%     repeatedly multiply by itself until the tmp converges/creates
%     eigenvector
while tmp~=TM*tmp
    %         just to keep track of iterations k
    tmp=TM*tmp;
    k=k+1;
end
rank=tmp;
end

function rankM=PageRanker(TM,factor)
% creates a matrix using dampening factor alpha where the matrix is
% computed by (1-alpha)*A+alpha*B where A is the Transition matrix of a
% graph and B is 1/n*ones(n,n). n is the length of A

B=sparse(ones(size(TM)));
n=length(TM);
rankM=(1-factor)*TM+(factor/n)*B;
end
