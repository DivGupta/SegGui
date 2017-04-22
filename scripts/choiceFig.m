function choice = choiceFig

fig = figure;
choice = 0;
b1 = uicontrol(fig,'Style','pushbutton','String','All in folder',...
    'Units','normalized','Position', [0 0 1/2 1],'Callback',@pushbutton_callbacka);
b2 = uicontrol(fig,'Style','pushbutton','String','Specific Model',...
    'Units','normalized','Position', [1/2 0 1/2 1],'Callback',@pushbutton_callbackb);
    
    function pushbutton_callbacka(~,~)
        choice = 1;
    end

    function pushbutton_callbackb(~,~)
        choice = 2;
    end

while choice == 0
    pause(.1)
end

end
