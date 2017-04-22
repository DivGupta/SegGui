function output = findCenter(points)

output = [];
for i = 1:length(points)
    
    temp = points{i};
    
    curX = temp(:,1);
    curY = temp(:,2);
    curZ = temp(:,3);
    
%     x = (min(curX) + max(curX))/2;
%     y = (min(curY) + max(curY))/2;
%     z = (min(curZ) + max(curZ))/2;

    x = mean(curX);
    y = mean(curY);
    z = mean(curZ);

    
    output = [output; [x,y,z]];
end