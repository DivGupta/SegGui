function ptSeg = findMinInside(seg, pts)

minD = 100000;
ptSeg = [];

for z = 1:size(pts, 2)
    len = length(seg);
    if len > 7
        len = 7;
    end
    for i = 1:len
        temp = seg{i};
        if ~isempty(temp)
            temp = temp{1};
        else
            break
        end
        l = size(temp, 1);
        for x = 1:l
            
            x2 = temp(x, 1);
            y2 = temp(x, 2);
            z2 = temp(x, 3);
            
            x3 = pts(1, z);
            y3 = pts(2, z);
            z3 = pts(3, z);
            
            a = sqrt( (x2-x3)^2 + (y2-y3)^2 + (z2-z3)^2);
            
            
            if a < minD
                minD = a;
                loc = i;
            end
            
        end
    end
    minD = 100000;
    ptSeg = [ptSeg, loc];
    
end

