function feels = getFeeling(Xtest, X)
% Return the index of the most likely feeling of Xtest compared with the training set X

min = Inf;
index=0;
dist=[];
for i = 1:size(X, 1)
    dist = [dist;sqrt(sum((X(i) - Xtest) .^ 2))];
%     if min>dist
%         min=dist;
%         index=i;
%     end
end
dist
feels = knn(dist,5)

%feel = index;


function listOfFeelings = knn(distance,k)
% Performs k-nearest Neighbor
listOfFeelings =[];
for i = 1:k
    p=Inf;
    for j = 1:size(distance,1)
        if distance(j)<p && all(listOfFeelings~=j)
            p=distance(j);
            indice = j;
        end
    end
    listOfFeelings = [listOfFeelings;indice];
end