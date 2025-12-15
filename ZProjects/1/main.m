clc; clear; close all;

figure('Color','k'); %[output:99c00837]
axis equal %[output:99c00837]
axis off %[output:99c00837]
hold on %[output:99c00837]
view(3) %[output:99c00837]
grid on %[output:99c00837]

scripts.init.load_station
scripts.init.load_train %[output:114e8a16]
scripts.init.setup_camera
scripts.init.assemble_scene

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":34.4}
%---
%[output:99c00837]
%   data: {"dataType":"image","outputData":{"dataUri":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKUAAAB7CAYAAAAVH0CFAAADe0lEQVR4AezS0arcOgxA0eH+\/z\/fNjAwjomJ\/VBJxgt6aBIM1izt\/z6fz\/\/+GFRq4Iry7zz+EagjIMo6uzDJV0CUXwj\/1REQZZ1dmOQrIMovhP\/qCORHWcfCJEUERFlkEcb4CYjyZ+GpiIAoiyzCGD8BUf4sPBUREGWRRRjjJyDKz+en4amEgChLrMEQrYAoWw3PJQREWWINhmgFRNlqeC4hIMoSazBEKyDKViPr2b03AVHeOLxUEBBlhS2Y4SYgyhuHlwoCoqywBTPcBER54\/BSQUCUFbaQP0OpCURZah2GuQREeSn4KyUgylLrMMwlIMpLwV8pAVGWWodhLgFRXgr+8gWaCUTZYHisISDKGnswRSMgygbDYw0BUdbYgykaAVE2GB5rCIiyxh5M0QgkRdlM4JFAJyDKDsRrvoAo83dggk5AlB2I13wBUebvwASdgCg7EK\/5AsdGmU9vgpGAKEcyvqcJiDKN3sUjAVGOZHxPExBlGr2LRwKiHMn4niYgyjR6F48ERDmS8T1NQJRp9C4eCYhyJON7moAo0+hdPBIQ5UjG9zQBUabR519cdQJRVt3MwXOJ8uDlV\/3poqy6mYPnEuXBy6\/600VZdTMHzyXKg5ef\/9OfJxDls4uviQKiTMR39bOAKJ9dfE0UEGUivqufBUT57OJrooAoE\/Fd\/SwQGeXzBL4S6ARE2YF4zRcQZf4OTNAJiLID8ZovIMr8HZigExBlB+I1X+CsKPO9TTAhIMoJJEdiBUQZ6+22CQFRTiA5Eisgylhvt00IiHICyZFYAVHGerttQkCUE0iOxAqIMtbbbRMCopxAciRWQJSx3m6bEBDlBJIjsQKijPXOv22DCUS5wZJOG1GUp218g98ryg2WdNqIojxt4xv8XlFusKTTRhTlaRvP\/72vE4jylciBaAFRRou771VAlK9EDkQLiDJa3H2vAqJ8JXIgWkCU0eLuexX451G+TuAAgU5AlB2I13wBUebvwASdgCg7EK\/5AqLM34EJOgFRdiBe8wUOiDIf2QRrAqJc83I6QECUAciuWBMQ5ZqX0wECogxAdsWagCjXvJwOEBBlALIr1gREuebldICAKAOQXbEmIMo1L6cDBEQZgOyKNQFRrnk5HSAgygDk\/Cv2mkCUe+3riGlFecSa9\/qRotxrX0dMK8oj1rzXjxTlXvs6Yto\/AAAA\/\/\/5P+QAAAAABklEQVQDAH0dpVJt3Ft4AAAAAElFTkSuQmCC","height":94,"width":125}}
%---
%[output:114e8a16]
%   data: {"dataType":"error","outputData":{"errorType":"runtime","text":"Unable to resolve the name 'scripts.init.load_train'."}}
%---
