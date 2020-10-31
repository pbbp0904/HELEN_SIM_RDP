function varargout = HELENMain(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HELENMain_OpeningFcn, ...
                   'gui_OutputFcn',  @HELENMain_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function HELENMain_OpeningFcn(hObject, eventdata, handles, varargin)

global fileName;
fileName = 'configRand.xls';

handles.output = hObject;
global fileRead;
global runNumber;
fileRead = 0;
hold(handles.error,'on');
hold(handles.error2,'on');
if exist('errors.xls', 'file') && 1
    %runNumber = length(xlsread('training.xlsx','Data'));
    [runNumber,~] = size(xlsread('errors.xls','Errors'));
    runNumber = runNumber - 1;
    %errors = xlsread('errors.xls','Errors');
    %scatter(handles.error,errors(:,6),errors(:,2),20,'filled','LineWidth',.05,'MarkerFaceColor',[0, 0, 1]);
    %scatter(handles.error2,errors(:,6),errors(:,3),20,'filled','LineWidth',.05,'MarkerFaceColor',[0, 0, 1]);
else
    runNumber = 0;
end
guidata(hObject, handles);

function varargout = HELENMain_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load, Run, Save Callbacks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function load_Callback(hObject, eventdata, handles)
global payloads; global tgf; global timing; global visual; %Global imports
global x; global y; global z; %Global coordinates
global scale; %Plotting scale
global fileRead;
global runNumber;
global timingMultiplier;
global fileName;
global payloadTimings;

timingMultiplier = 1;

%cla(handles.mainPlot,'reset');
%rotate3d on

if(fileRead==1&&0)
    payloads=xlsread(fileName,'Payloads');
    tgf=xlsread(fileName,'TGF');
    timing=double(xlsread(fileName,'Timing'));
    visual=xlsread(fileName,'Visual');
else
    payloads = (rand(4,3)*40)-20;
    payloads(:,3)=abs(payloads(:,3))+10;
    tgf = [0, 0, 10];
    timing = [20*10^-9 , 2];
    payloadTimings = normrnd(0,30*10^-9,1,4);
    visual = [5, 10];
end

%[x,y,z] = sphere;
%scale = visual(1,1);

%hold(handles.mainPlot,'on')
%surf(handles.mainPlot,x/scale+payloads(1,1),y/scale+payloads(1,2),z/scale+payloads(1,3),'EdgeColor','blue');
%surf(handles.mainPlot,x/scale+payloads(2,1),y/scale+payloads(2,2),z/scale+payloads(2,3),'EdgeColor','blue');
%surf(handles.mainPlot,x/scale+payloads(3,1),y/scale+payloads(3,2),z/scale+payloads(3,3),'EdgeColor','blue');
%surf(handles.mainPlot,x/scale+payloads(4,1),y/scale+payloads(4,2),z/scale+payloads(4,3),'EdgeColor','blue');

%set(handles.mainPlot,'XLim',[min(min(payloads(:,1)),tgf(1,1))-.4,max(max(payloads(:,1)),tgf(1,1))+.4]);
%set(handles.mainPlot,'YLim',[min(min(payloads(:,2)),tgf(1,2))-.4,max(max(payloads(:,2)),tgf(1,2))+.4]);
%set(handles.mainPlot,'ZLim',[min(min(payloads(:,3)),tgf(1,3))-.4,max(max(payloads(:,3)),tgf(1,3))+.4]);

%surf(handles.mainPlot,x/scale+tgf(1,1),y/scale+tgf(1,2),z/scale+tgf(1,3),'EdgeColor','green');

%payloads



function run_Callback(hObject, eventdata, handles)
global payloads; global tgf; global timing;  global visual;%Global imports
global x; global y; global z; %Global Coordinates
global errorx; global errory; global errorz; %Global errors
global scale;
global runNumber;
global timingMultiplier;
global payloadTimings;

runNumber=runNumber+1;

p1DistanceFromTGF = sqrt((payloads(1,1)-tgf(1,1))^2+(payloads(1,2)-tgf(1,2))^2+(payloads(1,3)-tgf(1,3))^2);
p2DistanceFromTGF = sqrt((payloads(2,1)-tgf(1,1))^2+(payloads(2,2)-tgf(1,2))^2+(payloads(2,3)-tgf(1,3))^2);
p3DistanceFromTGF = sqrt((payloads(3,1)-tgf(1,1))^2+(payloads(3,2)-tgf(1,2))^2+(payloads(3,3)-tgf(1,3))^2);
p4DistanceFromTGF = sqrt((payloads(4,1)-tgf(1,1))^2+(payloads(4,2)-tgf(1,2))^2+(payloads(4,3)-tgf(1,3))^2);

maxDistance = max(max(max(p1DistanceFromTGF,p2DistanceFromTGF),p3DistanceFromTGF),p4DistanceFromTGF)+.2;
maxTime = maxDistance/(299792.458);

%set(handles.mainPlot,'XLim',[min(min(payloads(:,1)),tgf(1,1))-.4,max(max(payloads(:,1)),tgf(1,1))+.4]);
%set(handles.mainPlot,'YLim',[min(min(payloads(:,2)),tgf(1,2))-.4,max(max(payloads(:,2)),tgf(1,2))+.4]);
%set(handles.mainPlot,'ZLim',[min(min(payloads(:,3)),tgf(1,3))-.4,max(max(payloads(:,3)),tgf(1,3))+.4]);

time = 0;
iteration = 0;
p1 = 0; p2 = 0; p3 = 0; p4 = 0;
timeStep = timing(1,1);
while time < maxTime
    format long g
    distance = time*(299792.458);
    
    %Check if payload is detecting TGF
    if(~p1 && distance>p1DistanceFromTGF)
        p1Time = (time+(time+timeStep))/2;
        %set(handles.time1,'String',strcat('Detection Time 1:',{'     '},num2str(p1Time*10^9,10)));
        p1 = 1;
    end
    if(~p2 && distance>p2DistanceFromTGF)
        p2Time = (time+(time+timeStep))/2;
        %set(handles.time2,'String',strcat('Detection Time 2:',{'     '},num2str(p2Time*10^9,10)));
        p2 = 1;
    end
    if(~p3 && distance>p3DistanceFromTGF)
        p3Time = (time+(time+timeStep))/2;
        %set(handles.time3,'String',strcat('Detection Time 3:',{'     '},num2str(p3Time*10^9,10)));
        p3 = 1;
    end
    if(~p4 && distance>p4DistanceFromTGF)
        p4Time = (time+(time+timeStep))/2;
        %set(handles.time4,'String',strcat('Detection Time 4:',{'     '},num2str(p4Time*10^9,10)));
        p4 = 1;
    end
    
    %Plotting
    %if(mod(iteration,floor((maxTime/timeStep)/visual(1,2)))==0)
        %hold(handles.mainPlot,'off')
        %surf(handles.mainPlot,x*distance+tgf(1,1),y*distance+tgf(1,2),z*distance+tgf(1,3),'EdgeColor','yellow','FaceAlpha',.05);
        %hold(handles.mainPlot,'on')
        %surf(handles.mainPlot,x/scale+payloads(1,1),y/scale+payloads(1,2),z/scale+payloads(1,3),'EdgeColor','blue');
        %surf(handles.mainPlot,x/scale+payloads(2,1),y/scale+payloads(2,2),z/scale+payloads(2,3),'EdgeColor','blue');
        %surf(handles.mainPlot,x/scale+payloads(3,1),y/scale+payloads(3,2),z/scale+payloads(3,3),'EdgeColor','blue');
        %surf(handles.mainPlot,x/scale+payloads(4,1),y/scale+payloads(4,2),z/scale+payloads(4,3),'EdgeColor','blue');
        %drawnow
    %end
    
    time=time+timeStep;
    iteration=iteration+1;
end

%plot3(handles.mainPlot,[tgf(1,1) payloads(1,1)],[tgf(1,2) payloads(1,2)],[tgf(1,3),payloads(1,3)],'k-','LineWidth',1,'Color',[1 0 0]);
%plot3(handles.mainPlot,[tgf(1,1) payloads(2,1)],[tgf(1,2) payloads(2,2)],[tgf(1,3),payloads(2,3)],'k-','LineWidth',1,'Color',[1 0 0]);
%plot3(handles.mainPlot,[tgf(1,1) payloads(3,1)],[tgf(1,2) payloads(3,2)],[tgf(1,3),payloads(3,3)],'k-','LineWidth',1,'Color',[1 0 0]);
%plot3(handles.mainPlot,[tgf(1,1) payloads(4,1)],[tgf(1,2) payloads(4,2)],[tgf(1,3),payloads(4,3)],'k-','LineWidth',1,'Color',[1 0 0]);

%axes(handles.mainPlot);
%imshow(imread('huntsville.jpg'), 'XData', [-45 45], 'YData', [-45 45]);

%xlim(handles.mainPlot,[-45 45]);
%ylim(handles.mainPlot,[-45 45]);
%zlim(handles.mainPlot,[0 40]);

%surf(handles.mainPlot,x/(scale-2)+tgf(1,1),y/(scale-2)+tgf(1,2),z/(scale-2)+tgf(1,3),'EdgeColor','magenta');
%drawnow
p1TimeMeasured = p1Time + payloadTimings(1);
p2TimeMeasured = p2Time + payloadTimings(2);
p3TimeMeasured = p3Time + payloadTimings(3);
p4TimeMeasured = p4Time + payloadTimings(4);
[x0,y0,z0,xp,yp,zp] = TGFSolve(payloads,[p1TimeMeasured,p2TimeMeasured,p3TimeMeasured,p4TimeMeasured],tgf);

% hold(handles.mainPlot,'off')
% surf(handles.mainPlot,x/scale+tgf(1,1),y/scale+tgf(1,2),z/scale+tgf(1,3),'EdgeColor','magenta');
% hold(handles.mainPlot,'on')

% surf(handles.mainPlot,x/scale+payloads(1,1),y/scale+payloads(1,2),z/scale+payloads(1,3),'EdgeColor','blue');
% surf(handles.mainPlot,x/scale+payloads(2,1),y/scale+payloads(2,2),z/scale+payloads(2,3),'EdgeColor','blue');
% surf(handles.mainPlot,x/scale+payloads(3,1),y/scale+payloads(3,2),z/scale+payloads(3,3),'EdgeColor','blue');
% surf(handles.mainPlot,x/scale+payloads(4,1),y/scale+payloads(4,2),z/scale+payloads(4,3),'EdgeColor','blue');
% 
% surf(handles.mainPlot,x/scale+x0,y/scale+y0,z/scale+z0,'EdgeColor','red');

%drawnow
errorx = sqrt((x0-tgf(1,1))^2)*1000;
errory = sqrt((y0-tgf(1,2))^2)*1000;
errorz = sqrt((z0-tgf(1,3))^2)*1000;
errorxp = sqrt((xp-tgf(1,1))^2)*1000;
erroryp = sqrt((yp-tgf(1,2))^2)*1000;
errorzp = sqrt((zp-tgf(1,3))^2)*1000;
writex = cat(2,[errorx,errory,errorz],sqrt((errorx)^2+(errory^2)+(errorz^2)),timing(1,1),payloads(1,:),payloads(2,:),payloads(3,:),payloads(4,:),[p1Time,p2Time,p3Time,p4Time],[p1TimeMeasured,p2TimeMeasured,p3TimeMeasured,p4TimeMeasured],x0,y0,z0,xp,yp,zp);
xlswrite('errors.xls',writex,'Errors',strcat('A',num2str(runNumber)));
%writex = cat(2, payloads(1,:),payloads(2,:),payloads(3,:),payloads(4,:),[p1Time,p2Time,p3Time,p4Time],timing(1,1),tgf);
%xlswrite('training.xlsx',writex,'Data',strcat('A',num2str(runNumber)));
%scatter(handles.error,timing(1,1),sqrt((errorx)^2+(errory^2)+(errorz^2)),20,'filled','LineWidth',.05,'MarkerFaceColor',[0, 0, 1]);
fprintf('Run#: %i   X Error: %.5fm   Y Error: %.5fm   Z Error: %.5fm   Timing: %i \n', runNumber, errorx, errory, errorz, timing(1,1));
fprintf('Run#: %i  XP Error: %.5fm  YP Error: %.5fm  ZP Error: %.5fm   Timing: %i \n', runNumber, errorxp, erroryp, errorzp, timing(1,1));
%fprintf('Run#: %i\n', runNumber);



function runBunch_Callback(hObject, eventdata, handles)
global payloads; global tgf; global timing;  global visual;%Global imports
global x; global y; global z; %Global Coordinates
global errorx; global errory; global errorz; %Global errors
global scale;
global fileRead;
global runNumber;
global timingMultiplier;

i = 1;
j = 1;
fileRead = 1;
while j <= 5000
    load_Callback(hObject, eventdata, handles);
    run_Callback(hObject, eventdata, handles);
    j = j + 1;
end










% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
%save data






% --- Executes on button press in payloadSetup.
function payloadSetup_Callback(hObject, eventdata, handles)

% --- Executes on button press in TGFSetup.
function TGFSetup_Callback(hObject, eventdata, handles)

% --- Executes on button press in visualSetup.
function visualSetup_Callback(hObject, eventdata, handles)

% --- Executes on button press in dataCollectionSetup.
function dataCollectionSetup_Callback(hObject, eventdata, handles)


% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
pause
