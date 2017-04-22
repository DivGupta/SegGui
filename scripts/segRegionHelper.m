function anglesum = segRegionHelper(q, p, n, normal)

isIn = false;
EPSILON  = 0.0000001;
anglesum = 0;

xn = normal(1);
yn = normal(2);
zn = normal(3);

% for i = 1:n-1
    

    for i = 1:n
        x1 = p(i,1) - q(1);
        y1 = p(i,2) - q(2);
        z1 = p(i,3) - q(3);
        
        x2 = p(mod(i,n)+1,1) - q(1);
        y2 = p(mod(i,n)+1,2) - q(2);
        z2 = p(mod(i,n)+1,3) - q(3);
        
        m1 = (sqrt(x1^2 + y1^2 + z1^2));
        m2 = (sqrt(x2^2 + y2^2 + z2^2));
        
        if (m1*m2 <= EPSILON)
            anglesum = 2*3.15;
            break
        else
            costheta = (x1*x2 + y1*y2 + z1*z2) / (m1*m2);
        end
        anglesum = anglesum + acos(costheta);
    end
% end
end

