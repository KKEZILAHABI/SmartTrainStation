function load_train
global trainHandle

[x,y,z] = cylinder([1 1],20);
z = z * 4;

trainHandle = surf(x-20,y,z,'FaceColor','red','EdgeColor','none');
end
