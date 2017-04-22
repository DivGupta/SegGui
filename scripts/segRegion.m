function [pathArrayOuter, done, failed] = segRegion(DXL_POL,DXL_VER,fName, xyzp)

count = 0;
out = [];
fig = figure('Name', fName, 'ToolBar', 'figure', 'units','normalized','outerposition',[0 0 1 1])
cntr = 1;
loop = true;
overloop = true;
notSegmented = true;
output = [];
check = false;
robust = true;
newWorked = false;
done = false;
failed = false;
clicked = false;
pathArrayOuter = [];
pathArrayM = [];
pathArray = [];
oneDone = false;

ha = axes;
trisurf(DXL_POL,DXL_VER(:,1),DXL_VER(:,2),DXL_VER(:,3),2,'EdgeColor',[.5 .5 .5]);hold on;
% scatter3(xyzp(1,ind),xyzp(2,ind), xyzp(3,ind));
datacursormode on
dcm_obj = datacursormode(fig);
set(dcm_obj,'UpdateFcn',@myupdatefcn)


%bottom row of buttons
b1 = uicontrol(fig,'Style','pushbutton','String','Next Region',...
    'Units','normalized','Position', [0 0 1/5 .1],'Callback',@pushbutton_callback);
b2 = uicontrol(fig,'Style','pushbutton','String','Next Model',...
    'Units','normalized','Position', [2/5 0 1/5 .1],'Callback',@pushbutton_callback2);
b3 = uicontrol(fig,'Style','pushbutton','String','Done',...
    'Units','normalized','Position', [4/5 0 1/5 .1],'Callback',@pushbutton_callback3);
b4 = uicontrol(fig,'Style','pushbutton','String','Delete',...
    'Units','normalized','Position', [1/5 0 1/5 .1],'Callback',@pushbutton_callback4);
b5 = uicontrol(fig,'Style','pushbutton','String','Preview',...
    'Units','normalized','Position', [3/5 0 1/5 .1],'Callback',@pushbutton_callback9);


%rotate (on top left of gui) buttons
%left
button1 = uicontrol(fig,'Style','pushbutton','String','left',...
    'Units','normalized','Position', [0 .9 .05 .05],'Callback',@pushbutton_callback5);
%up
button2 = uicontrol(fig,'Style','pushbutton','String','up',...
    'Units','normalized','Position', [.05 .95 .05 .05],'Callback',@pushbutton_callback6);
%right
button3 = uicontrol(fig,'Style','pushbutton','String','right',...
    'Units','normalized','Position', [.1 .9 .05 .05],'Callback',@pushbutton_callback7);
%down
button4 = uicontrol(fig,'Style','pushbutton','String','down',...
    'Units','normalized','Position', [.05 .9 .05 .05],'Callback',@pushbutton_callback8);


    function txt = myupdatefcn(~,event_obj)
        pos = get(event_obj,'Position');
        txt = {''};
        %         txt = 'clicked';
        if  count == 0
            out = [out;pos];
            count = count+1;
        elseif count >0
            if min(round(pos) ~= round(out(count,:)))
                out = [out;pos];
                count = count+1;
            end
        end
    end

    function pushbutton_callback(hObject,callbackdata)
        if count > 2
            loop = false;
            oneDone = true;
        else
            while exist('handleToMessageBox', 'var')
                delete(handleToMessageBox);
                clear('handleToMessageBox');
            end
            handleToMessageBox= msgbox('Please select more points');
        end
    end

    function pushbutton_callback2(hObject,callbackdata)
        if newWorked
            notSegmented = false;
            overloop = false;
            loop = false;
            clicked = true;
        end
    end

    function pushbutton_callback3(hObject,callbackdata)
        %         if cntr < 6
        %             msgbox('Please select more points');
        %         else
        %             robust =false;
        %         end
        done = true;
        notSegmented = false;
        overloop = false;
        loop = false;
        clicked = true;
        
    end

    function pushbutton_callback4(hObject,callbackdata)
        pathArray = [];
        pos = [];
        out = [];
        count = 0;
        cntr = 1;
        loop = true;
        overloop = true;
        check = true;
        segRegionAstetics(pathArrayOuter, DXL_POL,DXL_VER, portion);
    end

%left
    function pushbutton_callback5(hObject,callbackdata)
        [az,el] = view;
        view(az-45, el);
    end
%up
    function pushbutton_callback6(hObject,callbackdata)
        [az,el] = view;
        view(az, el+45);
    end
%right
    function pushbutton_callback7(hObject,callbackdata)
        [az,el] = view;
        view(az+45, el);
    end
%down
    function pushbutton_callback8(hObject,callbackdata)
        [az,el] = view;
        view(az, el-45);
    end

    function pushbutton_callback9(hObject,callbackdata)
        figure;
        segRegionAstetics(pathArrayOuter, DXL_POL,DXL_VER, portion);
        if oneDone
            ptSeg = findMinInside(pathArrayOuter, xyzp);
            col = [0 0 0; 1 0 1; 0 1 1; 1 0 0; 1 .6 0; 0 1 0; 0.4118 0.5137 0.2235];
            trisurf(DXL_POL,DXL_VER(:,1),DXL_VER(:,2),DXL_VER(:,3),2,'EdgeColor',[.5 .5 .5]);hold on;
            for i = 1:size(xyzp, 2)
                if max(xyzp(:,i) ~= [0,0,0]')
                    scatter3(xyzp(1, i),xyzp(2, i),xyzp(3, i), 20, col(ptSeg(i),:), 'fill');
                end
            end
        end
        
    end

portion = 1;
while notSegmented
    while overloop
        while loop
            pause(.01)
            if check & size(out, 1) > 1
                out = out(2,:);
                count = 1;
                check = false;
            end
            if count > cntr
                [worked,path] = findTrailMain(out(cntr,:), out(cntr+1,:), DXL_POL,DXL_VER);
                if ~worked
                    out = out(1:count-1,:)
                    count = count -1;
                    try
                        while exist('handleToMessageBox', 'var')
                            delete(handleToMessageBox);
                            clear('handleToMessageBox');
                        end
                    catch ME
                        display(ME.message)
                        display(ME.stack.file)
                        display(['line: ', int2str(ME.stack.line)])
                        failed = true;
                    end
                    handleToMessageBox= msgbox('Please select a point closer to the last');
                    %             pause(.5)
                    %             allHandle = allchild(0);
                    %             allTag = get(allHandle, 'Tag');
                    %             isMsgbox = strncmp(allTag, 'Msgbox_', 7);
                    %             delete(allHandle(isMsgbox));
                else
                    cntr = cntr+1;
                    pathArray = [pathArray; path];
                end
                
            end
        end
        
        try
            if size(out) > 0
                [newWorked,path] = findTrailMain(out(cntr,:), out(1,:), DXL_POL,DXL_VER);
                if ~newWorked
                    while exist('handleToMessageBox', 'var')
                        delete(handleToMessageBox);
                        clear('handleToMessageBox');
                    end
                    handleToMessageBox= msgbox('Please select another point between the first and last selection');
                else
                    overloop = false;
                    pathArray = [pathArray; path];
                    pathArrayM = [pathArrayM, {pathArray}]
                    
                    pathArray = [];
                end
                loop = true;
            else
                overloop = false;
                loop = true;
            end
        catch ME
            close all
            display(ME.message)
            display(ME.stack.file)
            display(['line: ', int2str(ME.stack.line)])
            failed = true;
        end
        
        
    end
    pathArrayOuter = [pathArrayOuter, {pathArrayM}]
    if ~clicked
        segRegionAstetics(pathArrayOuter, DXL_POL,DXL_VER, portion);
        portion = portion+1;
    end
    
    pathArrayM = [];
    output= [output, {out}]
    out = []
    count = 0;
    cntr = 1;
    loop = true;
    overloop = true;
    pos = [];
    check = true;
end

% output = output(1:length(output)-1);
% tempVar = 0;
% marks = [];
% tempVar = 0;
% while tempVar < landmarks
%     tempVar = tempVar + 1;
%     cntr = 1;
%     pos = [];
%     out = [];
%     count = 0;
%     msgbox(['Please specify landmark ', num2str(tempVar),  ' in the following manner: ']);
%     while robust
%         pause(0.01)
%         if check & size(out, 1) > 0
%             out = [];
%             count = 0;
%             check = false;
%         end
%         if count >= cntr
%             scatter3(out(count, 1),out(count, 2),out(count, 3), 200, 'k', 'fill');
%             cntr = cntr+1;
%         end
%     end
%     out
%     marks = [marks;{out}]
%     check = true;
%     robust = true;
% end

% figure
% hold on
% h = plot3([out(1,1), out(4,1)], [out(1,2), out(4,2)], [out(1,3), out(4,3)]);
% set(h,'linewidth',10);
% for i = 2:4
%     h = plot3([out(i-1,1), out(i,1)], [out(i-1,2), out(i,2)], [out(i-1,3), out(i,3)]);
%     set(h,'linewidth',10);
% end
%
% [x, y] = size(out);
% A = out(x-3,:);
% B= out(x-2,:);
% C = out(x-1,:);
% D = out(x,:);
%
% AB= (B-A);
% AC = (C-A);
%
% eqnt = [AB(2)*AC(3) - AB(3)*AC(2),AB(3)*AC(1) - AB(1)*AC(3),AB(1)*AC(2) - AB(2)*AC(1)];
% d = -(eqnt*A');
%
% pt = D;
%
%     t = (eqnt(1)*(pt(1)-A(1)) + eqnt(2)*(pt(2)-A(2)) + eqnt(3)*(pt(3)-A(3)))/-(eqnt(1)^2 + eqnt(2)^2 + eqnt(3)^2);
%     x = eqnt(1)*t + pt(1);
%     y = eqnt(2)*t + pt(2);
%     z = eqnt(3)*t + pt(3);
%
% D = [x,y,z];
%
% line1 = (B-A); %
% line2 = (C-B);
% line3 = (D-C); %
% line4 = (A-D);
%
% Points = [A;B;C;D];
%
% normal = cross_product(line1, line2);
% normal = createUnitVector(normal)
% p = [line1;line2;line3;line4];
%
% contains = [];
%
% for i = 1:length(xyzp)
%     pt = xyzp(:,i);
%
%     t = (eqnt(1)*(pt(1)-A(1)) + eqnt(2)*(pt(2)-A(2)) + eqnt(3)*(pt(3)-A(3)))/-(eqnt(1)^2 + eqnt(2)^2 + eqnt(3)^2);
%     x = eqnt(1)*t + pt(1);
%     y = eqnt(2)*t + pt(2);
%     z = eqnt(3)*t + pt(3);
%
%     contains = [contains;segRegionHelper([x,y,z], p, 4, normal)];
% end

end




