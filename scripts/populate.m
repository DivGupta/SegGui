function [ver, pol] = populate(ver, pol)

[x,y] = size(pol);

[z,m] = size(ver);

counter = 1;

for i = 1:x
    a = pol(i,1);
    b = pol(i,2);
    c = pol(i,3);
    
    d = (ver(a,:) + ver(b,:) +ver(c,:))/3;
    
    new = z+i;
    ver(new,:) = d;
   
    n1 = [a, b, new];
    n2 = [c, new, a];
    n3 = [new, c, b];
    
    pol(x+counter,:) = n1;    
    counter = counter +1;
    
    pol(x+counter,:) = n2;
    counter = counter +1;
    
    pol(x+counter,:) = n3;
    counter = counter +1;
end