function  [center,InfoTree]  = updateTree( InfoTree,center,initial,nei,BaseCost,step )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
edges  = findEdges( nei );
[center,maxI,index]=updateParentLocation(edges,BaseCost);
InfoTree(step).parent.location=center;
InfoTree(step).parent.cost=distance(center,initial);
InfoTree(step).parent.info=[maxI,index];
InfoTree(step).neighbour.location=nei;
InfoTree(step).neighbour.cost=distance(repmat(initial,length(nei),1) , nei);
InfoTree(step).neighbour.info=BaseCost;



end

function [center,maxI,index]=updateParentLocation(edges,BaseCost)
        for k=1:size(BaseCost,1)-1
        gradient=BaseCost(k+1)-BaseCost(k);
        end
        [maxI,index]=min(BaseCost);

        switch index
            case 1
                [x,y]=intersection(edges(6),edges(1));
                x=x+2*0.9;y=y+2*0.5;
            case 2
                [x,y]=intersection(edges(3),edges(1));
            case 3
                [x,y]=intersection(edges(2),edges(4));
            case 4
                [x,y]=intersection(edges(3),edges(5));
            case 5
                [x,y]=intersection(edges(4),edges(6));
            case 6
                [x,y]=intersection(edges(5),edges(1));
        end
        center=([x y]);
end


function  edges  = findEdges( vertices )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(vertices)-1
    edges(i).x1=vertices(i,1);
    edges(i).x2=vertices(i+1,1);
    edges(i).y1=vertices(i,2);
    edges(i).y2=vertices(i+1,2);
end

end

