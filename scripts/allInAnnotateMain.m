function [all, loc] = allInAnnotateMain(targ, pol, ver)

[x,y] = size(ver);
[x1,y1] = size(targ);
loc = 0;
origin = mean(targ);

minD = 100000;
for i = 1:x
    
    x2 = origin(1);
    y2 = origin(2);
    z2 = origin(3);
    
    x3 = ver(i, 1);
    y3 = ver(i, 2);
    z3 = ver(i, 3);
    
    a = sqrt( (x2-x3)^2 + (y2-y3)^2 + (z2-z3)^2);
    
    
    if a < minD
        minD = a;
        loc = i;
    end
end

target = [];
for z =1:x1
    for i = 1:x
        if (find(round(ver(i,1)) == round(targ(z,1)) & round(ver(i,2)) == round(targ(z,2)) & round(ver(i,3)) == round(targ(z,3)) ));
            target = [target, i];
            break
        end
    end
end
loc
target = unique(target)
all = [loc];

all = allInAnnotate(loc, target, pol, all);
all = unique([all;target']);

