function marks = annotateAtria(DXL_POL,DXL_VER,xyzp,landmarks, ind)

close all
count = 0;
out = [];
fig = figure('ToolBar', 'figure');
cntr = 1;
robust = true;
marks = [];

trisurf(DXL_POL,DXL_VER(:,1),DXL_VER(:,2),DXL_VER(:,3),2,'EdgeColor',[.5 .5 .5]);hold on;
alpha(.01);
% scatter3(xyzp(1,ind),xyzp(2,ind), xyzp(3,ind));
datacursormode on
dcm_obj = datacursormode(fig);
set(dcm_obj,'UpdateFcn',@myupdatefcn)
b3 = uicontrol(fig,'Style','pushbutton','String','Next LandMark',...
    'Units','normalized','Position', [2/3 0 1/3 .1],'Callback',@pushbutton_callback3);

    function pushbutton_callback3(hObject,callbackdata)
%         if cntr < 6
%             msgbox('Please select more points');
%         else
            robust =false;
%         end
    end

    function txt = myupdatefcn(empty,event_obj)
        pos = get(event_obj,'Position');
        txt = {['x: ',num2str(pos(1))],...
            ['y: ',num2str(pos(2))], ['z: ',num2str(pos(3))]};
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

% msgbox('Please specify landmarks in the following manner: ');
% while count < landmarks
%     pause(0.01)
%     if count >= cntr
%         scatter3(out(count, 1),out(count, 2),out(count, 3), 500, 'k', 'fill');
%         cntr = cntr+1;
%     end
% end
% 
% marks = out;

msgbox(['Please specify landmark 1 in the following manner: ']);
tempVar = 0;
while tempVar < landmarks
    while robust
        pause(0.01)
        if count >= cntr
            scatter3(out(count, 1),out(count, 2),out(count, 3), 500, 'k', 'fill');
            cntr = cntr+1;
        end
    end
    msgbox(['Please specify landmark ', num2str(tempVar+2),  ' in the following manner: ']);
    tempVar = tempVar + 1;
    marks = [marks;{out}];
    cntr = 1;
    count = 0;
    out = [];
    robust = true;
end

end