function animate_doors(doorHandle)
for i=1:20
    doorHandle.YData = doorHandle.YData + 0.05;
    drawnow
end
end
