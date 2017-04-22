function [segments, ptSeg] = segRegionMain

% landmarks = 5;
% % [out,ind] = filt;
% % [ver, pol] = populate(DXL_VER, DXL_POL);

% load('marks.mat');
% load('ShellPatient5.mat')
% trisurf(DXL_POL,DXL_VER(:,1),DXL_VER(:,2),DXL_VER(:,3),2,'EdgeColor',[.5 .5 .5]);
% alpha(.01);

% [segments, marks]=segRegion(DXL_POL, DXL_VER,xyzp, landmarks);

% mkdir('segments');
% cd('segments');

choice = choiceFig;

close all;

done = false;
col = [0 0 0; 1 0 1; 0 1 1; 1 0 0; 1 .6 0; 0 1 0; 0.4118 0.5137 0.2235];

switch choice
    case 1
        try
            cd(uigetdir);
            x = ls;
            [a,b] = size(x)
            cntr = 3;
            while ~done & cntr <= a
                fName = x(cntr,:);
                while isempty(strfind(fName, 'ana_'))
                    cntr = cntr+1;
                    if cntr > a
                        error('no supported file found in specified directory');
                    end
                    fName = x(cntr,:);
                end
                load(fName);
                cntr = cntr+1;
                
                close all
                [segments, done, failed]=segRegion(DXL_POL, DXL_VER,fName, xyzp);
                if failed
                    break
                end
                if ~failed
                    ptSeg = findMinInside(segments, xyzp);
                    l = length(fName);
                    
                    len = length(segments);
                    if len > 7
                        segments = segments(1:7);
                    end
                    save(['annotated_',fName(l-4:l)], 'ptSeg', 'segments');
                    for i = 1:size(xyzp, 2)
                        if max(xyzp(:,i) ~= [0,0,0]')
                            scatter3(xyzp(1, i),xyzp(2, i),xyzp(3, i), 20, col(ptSeg(i),:), 'fill');
                        end
                    end
                end
            end
        catch ME
            display(ME.message)
            display(ME.stack.file)
            display(['line: ', int2str(ME.stack.line)])
        end
    case 2
        try
            fName = uigetfile;
            load(fName);
            
            close all
            [segments, done, failed]=segRegion(DXL_POL, DXL_VER,fName, xyzp);
            if ~failed
                ptSeg = findMinInside(segments, xyzp);
                l = length(fName);
                
                len = length(segments);
                if len > 7
                    segments = segments(1:7);
                end
                save(['annotated_',fName(l-5:l)], 'ptSeg', 'segments');
                for i = 1:size(xyzp, 2)
                    if max(xyzp(:,i) ~= [0,0,0]')
                        scatter3(xyzp(1, i),xyzp(2, i),xyzp(3, i), 20, col(ptSeg(i),:), 'fill');
                    end
                end
            end
            
        catch ME
            display(ME.message)
            display(ME.stack.file)
            display(['line: ', int2str(ME.stack.line)])
        end
end
close all
%---------------region grow
% hold on
% segments = segments{1};
% if ~failed
%     [all, ori] = allInAnnotateMain(segments{1}, DXL_POL, DXL_VER);
%     for i = 1:length(all)
%         scatter3(DXL_VER(all(i), 1),DXL_VER(all(i), 2),DXL_VER(all(i), 3), 100, 'b', 'fill');
%     end
%     scatter3(DXL_VER(ori, 1),DXL_VER(ori, 2),DXL_VER(ori, 3), 200, 'k', 'fill');
% end
%----------------------------

%----------------projection

% close all
% marks = findCenter(marks);
% load('ShellPatient5.mat')
% mks = annotateAtria(DXL_POL, DXL_VER,xyzp, landmarks) ;
% mks = findCenter(mks);

% [P, e] = projTrans1(marks(1:4,:)', marks(5,:)', mks(1:4,:)', mks(5,:)');
% [P,e] = projTrans2(marks', mks', 5)
% [P,e] = projTrans4(marks', mks', 5)
% [P,e] = projTrans3(marks', mks', 5)

% hold on
% Pt =fix(P)
% for i = 1:length(segments)
%     [x,y] = size(segments{i});
%     temp = [segments{i}, zeros(x,1)+1];
%     new = (P*temp')';
%     [x,y] = size(new);
%
%     out = [];
%     cntr = 0;
%     for t = 1:x
%         value = (new(t,1:3)/new(t,4));%*10000;
%         out = [out;value];
%         cntr = cntr+1;
%         scatter3(value(1),value(2),value( 3), 100, 'r', 'fill');
%         if cntr > 1
%             plot3([out(cntr, 1),out(cntr-1, 1)], [out(cntr, 2),out(cntr-1, 2)], [out(cntr, 3),out(cntr-1, 3)]);
%         end
%     end
%     plot3([out(1, 1),out(cntr, 1)], [out(1, 2),out(cntr, 2)], [out(1, 3),out(cntr, 3)]);
% end
%  out
%
% -------------------------------

end