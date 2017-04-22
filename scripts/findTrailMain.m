function [found,outPath] = findTrailMain(origin, targ, pol, ver)

h = msgbox('Patience grasshopper...','Building Path','help');
child = get(h,'Children');
delete(child(3)) 

[x,y] = size(ver);

loc = 0;
for i = 1:x
    if (find(round(ver(i,1)) == round(origin(1)) & round(ver(i,2)) == round(origin(2)) & round(ver(i,3)) == round(origin(3)) ))
        loc = i;
        break
    end
end

for i = 1:x
    if (find(round(ver(i,1)) == round(targ(1)) & round(ver(i,2)) == round(targ(2)) & round(ver(i,3)) == round(targ(3)) ))
        target = i;
        break
    end
end

depth = 0;
path = [];
done = [];

[depth, path, found] = findTrailGreedy(loc, target, pol, ver, depth, path);
% [depth, path] = findTrail(loc, target, pol, ver, depth, path, done);

if found
   plotTrail(ver, path);
end

outPath = [];
for i = 1:length(path)
    outPath = [outPath; ver(path(i),:)];
end
delete(h);