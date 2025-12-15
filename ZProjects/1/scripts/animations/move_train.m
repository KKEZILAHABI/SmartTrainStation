function move_train
global trainHandle

for x = -20:0.1:20
    set(trainHandle,'XData',get(trainHandle,'XData')+0.1)
    drawnow
end
end
