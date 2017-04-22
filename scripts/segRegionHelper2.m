function out= segRegionHelper2(v,p, epi, targ)

xe = epi(1);
ye = epi(2);
ze = epi(3);

vec = epi - targ;

xv = vec(1);
yv = vec(2);
zv = vec(3);

for i = 1:4
    x1 = p(i,1);
    y1 = p(i,2);
    z1 = p(i,3); 
    
    xsv = v(i,1);
    ysv = v(i,2);
    zsv = v(i,3);
    
    if xsv/xv == ysv/yv == zsv/zv
    else
       a = (xe - x1) 
    end
    
end
