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
% [pk,prank]=pageRankVector(TM)
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
% from fileName. Outputs a full matrix since dampening will make the matrix
% not sparse
    s=load(fileName);
    M=spconvert(s);

% turn into a regular matrix
    M=full(M)
    [w,lgth]=size(M);
    if w>lgth
       sM=w;
    else
        sM=lgth;
    end

% ensure matrix is square
    resize=zeros(1,sM);
    resize(1:w,1:lgth)=M(1:w,1:lgth);

% get the number of ones in each row
    counts=sum(spones(resize),2)
    full(resize)
% check to see the size of matrix and use parallel computing for 10,000 X
% 10,000 matrix other wise just a regular for loop. Divide each row by the
% number of ones in that row.
    if(sM>10000)
        parfor row=1:sM
            if(counts(row,1)~=0)
                resize(row,:)=resize(row,:)/counts(row,1);
            end
        end
        resize(isnan(resize))=0;
    else
        for row=1:sM
            if(counts(row,1)~=0)
                resize(row,:)=resize(row,:)/counts(row,1);
            end
        end

    end

% replaces all NaNs with zeros

    resize(isnan(resize))=0;
% return the transpose matrix (matrix is row stochastic, turn to column
% stochastic)
    TM=resize';
end


function [k,rank]=pageRankVector(TM)
% pageRankVector - to compute the eigenvector using PageRank
% TM=transition matrix
% outputs the eigenvector and the number of iterations it needs to succeed

    [rows,columns]=size(TM);

    v=ones(columns,1);
    v=v/columns
    k=1;
    tmp=TM*v;
% repeatedly multiply by itself until the tmp converges/creates
% eigenvector
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
    B=ones(size(TM));
    n=length(TM);
    rankM=(1-factor)*TM+(factor/n)*B;
end
