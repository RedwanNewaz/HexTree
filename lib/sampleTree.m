function [ path,taken,robot ] = sampleTree( robot,area,nei,path,taken )
  
        i=1; 
        dista=[];
    while(i<length(nei))
        indexNei=round(nei(i,1)+area(2)*nei(i,2));
        if(find(taken==indexNei))
             dista(i,:)=10000;      
        else 
              dista(i,:)=distance(robot,nei(i,:));
        end
        i=i+1;
    end
      [minoi,index]=min(dista);
      GLINDEX=round(nei(:,1)+area(2)*nei(:,2));
        if(minoi<7)            
             [ path,taken,robot ] = sampleTree( nei(index,:),area,nei,[path;robot],[taken;GLINDEX(index)] );
        else 
            path=[path;robot];
            taken=[taken;GLINDEX(index)] ;
        end

end



%     GLINDEX=int8(nei(:,1)+area(2)*nei(:,2));
%     for j=1:length(nei)
%     step=0;
%     while(step<length(nei))
%         i=step+1;
%         indexNei=int8(nei(i,1)+area(2)*nei(i,2));
%         if(find(taken==indexNei))
%              dista(i,:)=10000;      
%         else 
%               dista(i,:)=distance(robot,nei(i,:));
%         end
%         step=step+1;
%     end
%         [minoi,index]=min(dista);
% %         taken=[taken;GLINDEX(index)];
% %           path=[path;robot];
% %         robot=nei(index,:);  
%         [ path,taken,robot ] = sampleTree( nei(index,:),area,nei,[path;robot],[taken;GLINDEX(index)] );
%     end