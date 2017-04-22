function [depth, path] = findTrail(origin, target, pol, ver, depth, path, done)

depth = depth + 1;
path = [path, origin];

if depth > 100
    depth = 1000000;
    return
end

[x,y] = size(pol);

locations = [];
for i = 1:x
    if (find(pol(i,:) == origin))
        locations = [locations; pol(i,:)];
    end
end

allT = unique(locations);
all = [];

for i = 1:length(allT)
    x1 = ver(origin, 1);
    y1 = ver(origin, 2);
    z1 = ver(origin, 3);
    
    x2 = ver(allT(i), 1);
    y2 = ver(allT(i), 2);
    z2 = ver(allT(i), 3);
    
    x3 = ver(target, 1);
    y3 = ver(target, 2);
    z3 = ver(target, 3);
    
    if sqrt( (x2-x3)^2 + (y2-y3)^2 + (z2-z3)^2) < sqrt( (x1-x3)^2 + (y1-y3)^2 + (z1-z3)^2)
        all = [all, allT(i)];
    end

end
depthO = 1000000;
pathO = [];
check = false;

if (max(all == target) == 1)
    return;
else
    for i = 1:length(all)
        if ~any(path == all(i)) | ~any(done == all(i))
            [depthN, pathN] = findTrail(all(i), target, pol, ver, depth, path,unique([done, all]))
            if depthN < depthO
                check = true;
                depthO = depthN;
                pathO = pathN;
            end
        end
    end
end

if check 
    depth = depth + depthO;
end
path = [path, pathO];
        
    