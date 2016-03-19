function dist = calcKDistance(k,points)
    N = size(points,1);
    for i=1:N
        dists = zeros(N,1);
        for idx = 1 : N
            dists(idx) = sqrt(sum((points(idx,:) - points(i,:)).^2));
        end
        [d,ind] = sort(dists);
        temp=[];
        for j=2:k+1
            temp=[temp,d(j)];
        end
        dist(i,:)=temp;
    end
end