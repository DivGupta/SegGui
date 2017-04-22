function h = plotTrail(ver, loc)

tem = length(loc);
scatter3(ver(loc(1), 1),ver(loc(1), 2),ver(loc(1), 3), 100, 'b', 'fill');
h(1) = ver(loc(1), 1),ver(loc(1), 2),ver(loc(1), 3)
for i = 1:tem-1
    if i > 1
        h(i) = scatter3(ver(loc(i), 1),ver(loc(i), 2),ver(loc(i), 3), 20, 'r', 'fill');
    end
    plot3([ver(loc(i), 1),ver(loc(i+1), 1)], [ver(loc(i), 2),ver(loc(i+1), 2)], [ver(loc(i), 3),ver(loc(i+1), 3)]);
end
ver(loc(tem), 1),ver(loc(tem), 2),ver(loc(tem), 3)
h(tem) = scatter3(ver(loc(tem), 1),ver(loc(tem), 2),ver(loc(tem), 3), 100, 'b', 'fill');