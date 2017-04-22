function output = allInAnnotate(origin, target, pol, all)

if ismember(origin, target)
    output = origin;
    display('dog'); return;
end

[x,y] = size(pol);

locations = [];
for i = 1:x 
    if (ismember(origin,pol(i,:)))
        locations = [locations; pol(i,:)];
    end
end

allT = unique(locations);
next = allT( ~ismember( allT, all ) );
all = [all; allT];

temp = [];
for i = 1:length(next)
%     if ~ismember(next(i), temp)
        temp = [temp;  allInAnnotate(next(i), target, pol, all)];
%     end
end
output = unique([temp;all])

end