function [ s_path ] = plot_graph( iteration,vertices,edges, simcase,plot_en )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if(nargin<5)
    plot_en=1;
end
    
if(simcase)
    if (plot_en)
          for ii = 1 : length(vertices)-1
              scatter(vertices(ii,1),vertices(ii,2),'white*','linewidth',2)
          end
          jj=length(edges);
         plot(edges(1:jj,1),edges(1:jj,2),'cyan','LineWidth',2)
    end
 s_path=path_length(edges(1:iteration,:));


else
     if (plot_en)
         [edgesRowCount, ~] = size(edges);
        for ii = 1 : edgesRowCount
            plot(vertices(ii, 1), vertices(ii, 2), 'white*', 'linewidth', 2);
            plot([vertices(edges(ii, 1), 1), vertices(edges(ii, 2), 1)], ...
            [vertices(edges(ii, 1), 2), vertices(edges(ii, 2), 2)], ...
             'cyan', 'LineWidth', 2);
        end
     end
     s_path=path_length(edges(1:iteration,:));
end

end

