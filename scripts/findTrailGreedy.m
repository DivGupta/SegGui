function [depth, path, found] = findTrailGreedy(origin, target, pol, ver, depth, path)

depth = depth + 1;
path = [path, origin];

if depth > 200
    found = false;
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

curDir = 0;
curDist = 1000;

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
    
    a = sqrt( (x2-x3)^2 + (y2-y3)^2 + (z2-z3)^2);
    b = sqrt( (x1-x3)^2 + (y1-y3)^2 + (z1-z3)^2);
    
    if a < curDist & ~any(path == allT(i))
        curDist = a;    
        curDir = allT(i);
    end
end

depthO = 1000000;
pathO = [];
check = false;

if curDir == target
    path = [path, target];
    depth = depth +1;
    found = true;
    return;
else
    
    [depthN, pathN, found] = findTrailGreedy(curDir, target, pol, ver, depth, []);
    if depthN < depthO & found
        check = true;
        depthO = depthN;
        pathO = pathN;
    end
end
if check
    depth = depth + depthO;
end
path = [path, pathO];

    