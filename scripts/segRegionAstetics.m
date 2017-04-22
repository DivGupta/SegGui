function segRegionAstetics(segments, DXL_POL,DXL_VER, in)

cla
trisurf(DXL_POL,DXL_VER(:,1),DXL_VER(:,2),DXL_VER(:,3),2,'EdgeColor',[.5 .5 .5]);hold on;
col = [0 0 0; 1 0 1; 0 1 1; 1 0 0; 1 .6 0; 0 1 0; 0.4118 0.5137 0.2235];

len= length(segments);
if len > 7
    len = 7;
end
% for i= 1:in
    for z = 1:len
        t = segments{z};
        temp = t{1};
        for x = 1:length(temp)-1
            plot3([temp(x,1),temp(x+1,1)], [temp(x,2),temp(x+1,2)], [temp(x,3),temp(x+1,3)], 'LineWidth',10, 'color', col(z,:));
            
            %     scatter3(segments(x,1),segments(x,2),segments(x,3), 100, 'r', 'fill');
        end
    end
    
    % scatter3(segments(x+1,1),segments(x+1,2),segments(x+1,3), 100, 'r', 'fill');
% end

end