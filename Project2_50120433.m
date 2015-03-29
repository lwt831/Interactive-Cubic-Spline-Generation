function varargout = Project2_50120433(varargin)
% PROJECT2_50120433 MATLAB code for Project2_50120433.fig
%      PROJECT2_50120433, by itself, creates a new PROJECT2_50120433 or raises the existing
%      singleton*.
%
%      H = PROJECT2_50120433 returns the handle to a new PROJECT2_50120433 or the handle to
%      the existing singleton*.
%
%      PROJECT2_50120433('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT2_50120433.M with the given input arguments.
%
%      PROJECT2_50120433('Property','Value',...) creates a new PROJECT2_50120433 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Project2_50120433_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Project2_50120433_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Project2_50120433

% Last Modified by GUIDE v2.5 27-Mar-2015 23:12:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project2_50120433_OpeningFcn, ...
                   'gui_OutputFcn',  @Project2_50120433_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Project2_50120433 is made visible.
function Project2_50120433_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Project2_50120433 (see VARARGIN)
% Choose default command line output for Project2_50120433
handles.output = hObject;
str = 'Press <Clear Screen> to Begin! :)'
text(-1,1,str,'FontSize' , 15)
% Update handles structure

%% Initializing the Parameters

guidata(hObject, handles);

axis([-10 15 -10 10])
global points;
global points1;
global pID;
global drawing;
global a b c d;
global i j ;
a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));
points = ones(2,20);  
pID = 0;                % This variable counts the number of captured points
drawing = 0;            % This is a drawing flag (1: subject is drawing, 0: subject is not drawing)

hold on

set(gcf,'WindowButtonDownFcn',@mouseDown,'WindowButtonUpFcn',@mouseUp)



% UIWAIT makes Project2_50120433 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Project2_50120433_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function textx1_Callback(hObject, eventdata, handles)
% hObject    handle to textx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global pID;
global points;
global points1;
drawing =0;
pID = 0;
points = [];
points1= [];
clc;
cla;
% Data Point
%Pnt = [0 1; 1 -2; 3 4; 4 3; 4 0; 4 9; 7 -1; 8 -5; 9 2; 10 1];

syms x1 x2 x3 x4 y1 y2 y3 y4 

x1 = str2num(get(handles.textx1, 'String'))
x2 = str2num(get(handles.textx2, 'String'))
x3 = str2num(get(handles.textx3, 'String'))
x4 = str2num(get(handles.textx4, 'String'))

y1 = str2num(get(handles.texty1, 'String'))
y2 = str2num(get(handles.texty2, 'String'))
y3 = str2num(get(handles.texty3, 'String'))
y4 = str2num(get(handles.texty4, 'String'))

Pnt = [x1 x2 x3 x4; y1 y2 y3 y4 ];
Pnt= Pnt';
% Two tangent vector defined at ith and jth point

a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));

Pdj = [c d];      j = 4;


Pdi = [a b];    i = 1; 


n = length(Pnt);
M = eye(n-2); O = zeros(n-2,1);
A = [M O O] + [O 4*M O] + [O O M];
B = 3*Pnt(3:end,:) - 3*Pnt(1:end-2,:);

B = B - A(:,i)*Pdi;
B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

A(:,[i j]) = [];

X = inv(A)*B;
id = 1:n;   id([i j]) = [];

%Pd is the Tangent vector at all points 
Pd = zeros(n,2);
Pd(id,:) = X;
Pd(i,:) = Pdi;
Pd(j,:) = Pdj;

for i=1:n-1
    P2 = HermitInterpolation(Pnt(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
end
plot(Pnt(:,1),Pnt(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
xlim([-10 15])
ylim([-10 10])

% Hints: get(hObject,'String') returns contents of textx1 as text
%        str2double(get(hObject,'String')) returns contents of textx1 as a double


% --- Executes during object creation, after setting all properties.
function textx1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textx2_Callback(hObject, eventdata, handles)
% hObject    handle to textx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global pID;
global points;
global points1;
drawing =0;
pID = 0;
points = [];
points1= [];
clc;
cla;
% Data Point
%Pnt = [0 1; 1 -2; 3 4; 4 3; 4 0; 4 9; 7 -1; 8 -5; 9 2; 10 1];

syms x1 x2 x3 x4 y1 y2 y3 y4 

x1 = str2num(get(handles.textx1, 'String'))
x2 = str2num(get(handles.textx2, 'String'))
x3 = str2num(get(handles.textx3, 'String'))
x4 = str2num(get(handles.textx4, 'String'))

y1 = str2num(get(handles.texty1, 'String'))
y2 = str2num(get(handles.texty2, 'String'))
y3 = str2num(get(handles.texty3, 'String'))
y4 = str2num(get(handles.texty4, 'String'))

Pnt = [x1 x2 x3 x4; y1 y2 y3 y4 ];
Pnt= Pnt';
% Two tangent vector defined at ith and jth point

a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));

Pdj = [c d];      j = 4;


Pdi = [a b];    i = 1; 


n = length(Pnt);
M = eye(n-2); O = zeros(n-2,1);
A = [M O O] + [O 4*M O] + [O O M];
B = 3*Pnt(3:end,:) - 3*Pnt(1:end-2,:);

B = B - A(:,i)*Pdi;
B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

A(:,[i j]) = [];

X = inv(A)*B;
id = 1:n;   id([i j]) = [];

%Pd is the Tangent vector at all points 
Pd = zeros(n,2);
Pd(id,:) = X;
Pd(i,:) = Pdi;
Pd(j,:) = Pdj;

for i=1:n-1
    P2 = HermitInterpolation(Pnt(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
end
plot(Pnt(:,1),Pnt(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
xlim([-10 15])
ylim([-10 10])

% Hints: get(hObject,'String') returns contents of textx2 as text
%        str2double(get(hObject,'String')) returns contents of textx2 as a double


% --- Executes during object creation, after setting all properties.
function textx2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textx3_Callback(hObject, eventdata, handles)
% hObject    handle to textx3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global pID;
global points;
global points1;
drawing =0;
pID = 0;
points = [];
points1= [];
clc;
cla;
% Data Point
%Pnt = [0 1; 1 -2; 3 4; 4 3; 4 0; 4 9; 7 -1; 8 -5; 9 2; 10 1];

syms x1 x2 x3 x4 y1 y2 y3 y4 

x1 = str2num(get(handles.textx1, 'String'))
x2 = str2num(get(handles.textx2, 'String'))
x3 = str2num(get(handles.textx3, 'String'))
x4 = str2num(get(handles.textx4, 'String'))

y1 = str2num(get(handles.texty1, 'String'))
y2 = str2num(get(handles.texty2, 'String'))
y3 = str2num(get(handles.texty3, 'String'))
y4 = str2num(get(handles.texty4, 'String'))

Pnt = [x1 x2 x3 x4; y1 y2 y3 y4 ];
Pnt= Pnt';
% Two tangent vector defined at ith and jth point

a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));

Pdj = [c d];      j = 4;


Pdi = [a b];    i = 1; 


n = length(Pnt);
M = eye(n-2); O = zeros(n-2,1);
A = [M O O] + [O 4*M O] + [O O M];
B = 3*Pnt(3:end,:) - 3*Pnt(1:end-2,:);

B = B - A(:,i)*Pdi;
B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

A(:,[i j]) = [];

X = inv(A)*B;
id = 1:n;   id([i j]) = [];

%Pd is the Tangent vector at all points 
Pd = zeros(n,2);
Pd(id,:) = X;
Pd(i,:) = Pdi;
Pd(j,:) = Pdj;

for i=1:n-1
    P2 = HermitInterpolation(Pnt(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
end
plot(Pnt(:,1),Pnt(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
xlim([-10 15])
ylim([-10 10])

% Hints: get(hObject,'String') returns contents of textx3 as text
%        str2double(get(hObject,'String')) returns contents of textx3 as a double


% --- Executes during object creation, after setting all properties.
function textx3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textx3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textx4_Callback(hObject, eventdata, handles)
% hObject    handle to textx4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global pID;
global points;
global points1;
drawing =0;
pID = 0;
points = [];
points1= [];
clc;
cla;
% Data Point
%Pnt = [0 1; 1 -2; 3 4; 4 3; 4 0; 4 9; 7 -1; 8 -5; 9 2; 10 1];

syms x1 x2 x3 x4 y1 y2 y3 y4 

x1 = str2num(get(handles.textx1, 'String'))
x2 = str2num(get(handles.textx2, 'String'))
x3 = str2num(get(handles.textx3, 'String'))
x4 = str2num(get(handles.textx4, 'String'))

y1 = str2num(get(handles.texty1, 'String'))
y2 = str2num(get(handles.texty2, 'String'))
y3 = str2num(get(handles.texty3, 'String'))
y4 = str2num(get(handles.texty4, 'String'))

Pnt = [x1 x2 x3 x4; y1 y2 y3 y4 ];
Pnt= Pnt';
% Two tangent vector defined at ith and jth point

a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));

Pdj = [c d];      j = 4;


Pdi = [a b];    i = 1; 


n = length(Pnt);
M = eye(n-2); O = zeros(n-2,1);
A = [M O O] + [O 4*M O] + [O O M];
B = 3*Pnt(3:end,:) - 3*Pnt(1:end-2,:);

B = B - A(:,i)*Pdi;
B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

A(:,[i j]) = [];

X = inv(A)*B;
id = 1:n;   id([i j]) = [];

%Pd is the Tangent vector at all points 
Pd = zeros(n,2);
Pd(id,:) = X;
Pd(i,:) = Pdi;
Pd(j,:) = Pdj;

for i=1:n-1
    P2 = HermitInterpolation(Pnt(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
end
plot(Pnt(:,1),Pnt(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
xlim([-10 15])
ylim([-10 10])

% Hints: get(hObject,'String') returns contents of textx4 as text
%        str2double(get(hObject,'String')) returns contents of textx4 as a double


% --- Executes during object creation, after setting all properties.
function textx4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textx4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function texty1_Callback(hObject, eventdata, handles)
% hObject    handle to texty1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global pID;
global points;
global points1;
drawing =0;
pID = 0;
points = [];
points1= [];
clc;
cla;
% Data Point
%Pnt = [0 1; 1 -2; 3 4; 4 3; 4 0; 4 9; 7 -1; 8 -5; 9 2; 10 1];

syms x1 x2 x3 x4 y1 y2 y3 y4 

x1 = str2num(get(handles.textx1, 'String'))
x2 = str2num(get(handles.textx2, 'String'))
x3 = str2num(get(handles.textx3, 'String'))
x4 = str2num(get(handles.textx4, 'String'))

y1 = str2num(get(handles.texty1, 'String'))
y2 = str2num(get(handles.texty2, 'String'))
y3 = str2num(get(handles.texty3, 'String'))
y4 = str2num(get(handles.texty4, 'String'))

Pnt = [x1 x2 x3 x4; y1 y2 y3 y4 ];
Pnt= Pnt';
% Two tangent vector defined at ith and jth point

a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));

Pdj = [c d];      j = 4;


Pdi = [a b];    i = 1; 


n = length(Pnt);
M = eye(n-2); O = zeros(n-2,1);
A = [M O O] + [O 4*M O] + [O O M];
B = 3*Pnt(3:end,:) - 3*Pnt(1:end-2,:);

B = B - A(:,i)*Pdi;
B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

A(:,[i j]) = [];

X = inv(A)*B;
id = 1:n;   id([i j]) = [];

%Pd is the Tangent vector at all points 
Pd = zeros(n,2);
Pd(id,:) = X;
Pd(i,:) = Pdi;
Pd(j,:) = Pdj;

for i=1:n-1
    P2 = HermitInterpolation(Pnt(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
end
plot(Pnt(:,1),Pnt(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
xlim([-10 15])
ylim([-10 10])

% Hints: get(hObject,'String') returns contents of texty1 as text
%        str2double(get(hObject,'String')) returns contents of texty1 as a double


% --- Executes during object creation, after setting all properties.
function texty1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texty1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function texty2_Callback(hObject, eventdata, handles)
% hObject    handle to texty2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global pID;
global points;
global points1;
drawing =0;
pID = 0;
points = [];
points1= [];
clc;
cla;
% Data Point
%Pnt = [0 1; 1 -2; 3 4; 4 3; 4 0; 4 9; 7 -1; 8 -5; 9 2; 10 1];

syms x1 x2 x3 x4 y1 y2 y3 y4 

x1 = str2num(get(handles.textx1, 'String'))
x2 = str2num(get(handles.textx2, 'String'))
x3 = str2num(get(handles.textx3, 'String'))
x4 = str2num(get(handles.textx4, 'String'))

y1 = str2num(get(handles.texty1, 'String'))
y2 = str2num(get(handles.texty2, 'String'))
y3 = str2num(get(handles.texty3, 'String'))
y4 = str2num(get(handles.texty4, 'String'))

Pnt = [x1 x2 x3 x4; y1 y2 y3 y4 ];
Pnt= Pnt';
% Two tangent vector defined at ith and jth point

a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));

Pdj = [c d];      j = 4;


Pdi = [a b];    i = 1; 


n = length(Pnt);
M = eye(n-2); O = zeros(n-2,1);
A = [M O O] + [O 4*M O] + [O O M];
B = 3*Pnt(3:end,:) - 3*Pnt(1:end-2,:);

B = B - A(:,i)*Pdi;
B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

A(:,[i j]) = [];

X = inv(A)*B;
id = 1:n;   id([i j]) = [];

%Pd is the Tangent vector at all points 
Pd = zeros(n,2);
Pd(id,:) = X;
Pd(i,:) = Pdi;
Pd(j,:) = Pdj;

for i=1:n-1
    P2 = HermitInterpolation(Pnt(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
end
plot(Pnt(:,1),Pnt(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
xlim([-10 15])
ylim([-10 10])

% Hints: get(hObject,'String') returns contents of texty2 as text
%        str2double(get(hObject,'String')) returns contents of texty2 as a double


% --- Executes during object creation, after setting all properties.
function texty2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texty2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function texty3_Callback(hObject, eventdata, handles)
% hObject    handle to texty3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global pID;
global points;
global points1;
drawing =0;
pID = 0;
points = [];
points1= [];
clc;
cla;
% Data Point
%Pnt = [0 1; 1 -2; 3 4; 4 3; 4 0; 4 9; 7 -1; 8 -5; 9 2; 10 1];

syms x1 x2 x3 x4 y1 y2 y3 y4 

x1 = str2num(get(handles.textx1, 'String'))
x2 = str2num(get(handles.textx2, 'String'))
x3 = str2num(get(handles.textx3, 'String'))
x4 = str2num(get(handles.textx4, 'String'))

y1 = str2num(get(handles.texty1, 'String'))
y2 = str2num(get(handles.texty2, 'String'))
y3 = str2num(get(handles.texty3, 'String'))
y4 = str2num(get(handles.texty4, 'String'))

Pnt = [x1 x2 x3 x4; y1 y2 y3 y4 ];
Pnt= Pnt';
% Two tangent vector defined at ith and jth point

a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));

Pdj = [c d];      j = 4;


Pdi = [a b];    i = 1; 


n = length(Pnt);
M = eye(n-2); O = zeros(n-2,1);
A = [M O O] + [O 4*M O] + [O O M];
B = 3*Pnt(3:end,:) - 3*Pnt(1:end-2,:);

B = B - A(:,i)*Pdi;
B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

A(:,[i j]) = [];

X = inv(A)*B;
id = 1:n;   id([i j]) = [];

%Pd is the Tangent vector at all points 
Pd = zeros(n,2);
Pd(id,:) = X;
Pd(i,:) = Pdi;
Pd(j,:) = Pdj;

for i=1:n-1
    P2 = HermitInterpolation(Pnt(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
end
plot(Pnt(:,1),Pnt(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
xlim([-10 15])
ylim([-10 10])

% Hints: get(hObject,'String') returns contents of texty3 as text
%        str2double(get(hObject,'String')) returns contents of texty3 as a double


% --- Executes during object creation, after setting all properties.
function texty3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texty3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function texty4_Callback(hObject, eventdata, handles)
% hObject    handle to texty4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global pID;
global points;
global points1;
drawing =0;
pID = 0;
points = [];
points1= [];
clc;
cla;
% Data Point
%Pnt = [0 1; 1 -2; 3 4; 4 3; 4 0; 4 9; 7 -1; 8 -5; 9 2; 10 1];

syms x1 x2 x3 x4 y1 y2 y3 y4 

x1 = str2num(get(handles.textx1, 'String'))
x2 = str2num(get(handles.textx2, 'String'))
x3 = str2num(get(handles.textx3, 'String'))
x4 = str2num(get(handles.textx4, 'String'))

y1 = str2num(get(handles.texty1, 'String'))
y2 = str2num(get(handles.texty2, 'String'))
y3 = str2num(get(handles.texty3, 'String'))
y4 = str2num(get(handles.texty4, 'String'))

Pnt = [x1 x2 x3 x4; y1 y2 y3 y4 ];
Pnt= Pnt';
% Two tangent vector defined at ith and jth point

a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));

Pdj = [c d];      j = 4;


Pdi = [a b];    i = 1; 


n = length(Pnt);
M = eye(n-2); O = zeros(n-2,1);
A = [M O O] + [O 4*M O] + [O O M];
B = 3*Pnt(3:end,:) - 3*Pnt(1:end-2,:);

B = B - A(:,i)*Pdi;
B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

A(:,[i j]) = [];

X = inv(A)*B;
id = 1:n;   id([i j]) = [];

%Pd is the Tangent vector at all points 
Pd = zeros(n,2);
Pd(id,:) = X;
Pd(i,:) = Pdi;
Pd(j,:) = Pdj;

for i=1:n-1
    P2 = HermitInterpolation(Pnt(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
end
plot(Pnt(:,1),Pnt(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
xlim([-10 15])
ylim([-10 10])

% Hints: get(hObject,'String') returns contents of texty4 as text
%        str2double(get(hObject,'String')) returns contents of texty4 as a double


% --- Executes during object creation, after setting all properties.
function texty4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texty4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tanx1_Callback(hObject, eventdata, handles)
% hObject    handle to tanx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global points;
global pID;
global points1;
global a b c d;
a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));
%Two tangent vector defined at ith and jth point
if pID > 3
    cla
    points1 =points';
    
    Pdj = [c d];      j = pID;
    Pdi = [a b];      i = 1; 
    n = pID;
    M = eye(n-2); O = zeros(n-2,1);
    A = [M O O] + [O 4*M O] + [O O M];
    B = 3*points1(3:pID,:) - 3*points1(1:pID-2,:);

    B = B - A(:,i)*Pdi;
    B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

    A(:,[i j]) = [];

    X = inv(A)*B
    id = 1:n;   id([i j]) = [];

    %Pd is the Tangent vector at all points 
    Pd = zeros(n,2);
    Pd(id,:) = X;
    Pd(i,:) = Pdi;
    Pd(j,:) = Pdj;
    for i=1:n-1
    P2 = HermitInterpolation(points1(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
    end
    plot(points1(:,1),points1(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
    xlim([-10 15])
    ylim([-10 10])
    drawing =0;
end
% Hints: get(hObject,'String') returns contents of tanx1 as text
%        str2double(get(hObject,'String')) returns contents of tanx1 as a double


% --- Executes during object creation, after setting all properties.
function tanx1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tanx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tany1_Callback(hObject, eventdata, handles)
% hObject    handle to tany1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tany1 as text
%        str2double(get(hObject,'String')) returns contents of tany1 as a double
global drawing;
global points;
global pID;
global points1;
global a b c d;
a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));
%Two tangent vector defined at ith and jth point
if pID > 3
    cla
    points1 =points';
   Pdj = [c d];      j = pID;
    Pdi = [a b];      i = 1; 

    n = pID;
    M = eye(n-2); O = zeros(n-2,1);
    A = [M O O] + [O 4*M O] + [O O M];
    B = 3*points1(3:pID,:) - 3*points1(1:pID-2,:);

    B = B - A(:,i)*Pdi;
    B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

    A(:,[i j]) = [];

    X = inv(A)*B
    id = 1:n;   id([i j]) = [];

    %Pd is the Tangent vector at all points 
    Pd = zeros(n,2);
    Pd(id,:) = X;
    Pd(i,:) = Pdi;
    Pd(j,:) = Pdj;
    for i=1:n-1
    P2 = HermitInterpolation(points1(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
    end
    plot(points1(:,1),points1(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
    xlim([-10 15])
    ylim([-10 10])
    drawing =0;
end

% --- Executes during object creation, after setting all properties.
function tany1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tany1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tanx2_Callback(hObject, eventdata, handles)
% hObject    handle to tanx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global points;
global pID;
global points1;
global a b c d;
a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));
%Two tangent vector defined at ith and jth point
if pID > 3
    cla
    points1 =points';
    Pdj = [c d];      j = pID;
    Pdi = [a b];      i = 1; 
    n = pID;
    M = eye(n-2); O = zeros(n-2,1);
    A = [M O O] + [O 4*M O] + [O O M];
    B = 3*points1(3:pID,:) - 3*points1(1:pID-2,:);

    B = B - A(:,i)*Pdi;
    B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

    A(:,[i j]) = [];

    X = inv(A)*B
    id = 1:n;   id([i j]) = [];

    %Pd is the Tangent vector at all points 
    Pd = zeros(n,2);
    Pd(id,:) = X;
    Pd(i,:) = Pdi;
    Pd(j,:) = Pdj;
    for i=1:n-1
    P2 = HermitInterpolation(points1(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
    end
    plot(points1(:,1),points1(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
    xlim([-10 15])
    ylim([-10 10])
    drawing =0;
end
% Hints: get(hObject,'String') returns contents of tanx2 as text
%        str2double(get(hObject,'String')) returns contents of tanx2 as a double


% --- Executes during object creation, after setting all properties.
function tanx2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tanx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tany2_Callback(hObject, eventdata, handles)
% hObject    handle to tany2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global points;
global pID;
global points1;
global a b c d;
a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));
%Two tangent vector defined at ith and jth point
if pID > 3
    cla
    points1 =points';
    
    Pdj = [c d];      j = pID;
    Pdi = [a b];      i = 1; 
    n = pID;
    M = eye(n-2); O = zeros(n-2,1);
    A = [M O O] + [O 4*M O] + [O O M];
    B = 3*points1(3:pID,:) - 3*points1(1:pID-2,:);

    B = B - A(:,i)*Pdi;
    B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

    A(:,[i j]) = [];

    X = inv(A)*B
    id = 1:n;   id([i j]) = [];

    %Pd is the Tangent vector at all points 
    Pd = zeros(n,2);
    Pd(id,:) = X;
    Pd(i,:) = Pdi;
    Pd(j,:) = Pdj;
    for i=1:n-1
    P2 = HermitInterpolation(points1(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
    end
    plot(points1(:,1),points1(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
    xlim([-10 15])
    ylim([-10 10])
    drawing =0;
end
% Hints: get(hObject,'String') returns contents of tany2 as text
%        str2double(get(hObject,'String')) returns contents of tany2 as a double


% --- Executes during object creation, after setting all properties.
function tany2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tany2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tan2y_Callback(hObject, eventdata, handles)
% hObject    handle to tan2y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tan2y as text
%        str2double(get(hObject,'String')) returns contents of tan2y as a double


% --- Executes during object creation, after setting all properties.
function tan2y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tan2y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to textx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textx1 as text
%        str2double(get(hObject,'String')) returns contents of textx1 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to textx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textx2 as text
%        str2double(get(hObject,'String')) returns contents of textx2 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to textx3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textx3 as text
%        str2double(get(hObject,'String')) returns contents of textx3 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textx3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to textx4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textx4 as text
%        str2double(get(hObject,'String')) returns contents of textx4 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textx4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to texty1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of texty1 as text
%        str2double(get(hObject,'String')) returns contents of texty1 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texty1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to texty2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of texty2 as text
%        str2double(get(hObject,'String')) returns contents of texty2 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texty2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to texty3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of texty3 as text
%        str2double(get(hObject,'String')) returns contents of texty3 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texty3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to texty4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of texty4 as text
%        str2double(get(hObject,'String')) returns contents of texty4 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texty4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to tany2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tany2 as text
%        str2double(get(hObject,'String')) returns contents of tany2 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tany2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to tanx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tanx2 as text
%        str2double(get(hObject,'String')) returns contents of tanx2 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tanx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to tany1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tany1 as text
%        str2double(get(hObject,'String')) returns contents of tany1 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tany1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to tanx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tanx1 as text
%        str2double(get(hObject,'String')) returns contents of tanx1 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tanx1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function P = HermitInterpolation(P,Pt)

% Four Point Interpolation
% P is a 4x2 matrix. Point 1 and 2. Each point is in a seprate row
% Pt is a 4x2 matrix. Tangent at Point 1 and 2. 

t = 0:0.01:1;   t = t';
T = [t.^3 , t.^2 , t, 0*t+1];
M = [2 -2 1 1; -3 3 -2 -1; 0 0 1 0; 1 0 0 0];

G = [P; Pt];
P = T*M*G;


% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global drawing;
global pID;
global points;
global points1;
drawing =0;
pID = 0;
points = [];
points1= [];
clc;
cla;
% Data Point
%Pnt = [0 1; 1 -2; 3 4; 4 3; 4 0; 4 9; 7 -1; 8 -5; 9 2; 10 1];

syms x1 x2 x3 x4 y1 y2 y3 y4 

x1 = str2num(get(handles.textx1, 'String'))
x2 = str2num(get(handles.textx2, 'String'))
x3 = str2num(get(handles.textx3, 'String'))
x4 = str2num(get(handles.textx4, 'String'))

y1 = str2num(get(handles.texty1, 'String'))
y2 = str2num(get(handles.texty2, 'String'))
y3 = str2num(get(handles.texty3, 'String'))
y4 = str2num(get(handles.texty4, 'String'))

Pnt = [x1 x2 x3 x4; y1 y2 y3 y4 ];
Pnt= Pnt';
% Two tangent vector defined at ith and jth point

a = str2num(get(handles.tanx1, 'String'));
b = str2num(get(handles.tany1, 'String'));
c = str2num(get(handles.tanx2, 'String'));
d = str2num(get(handles.tany2, 'String'));

Pdj = [c d];      j = 4;


Pdi = [a b];    i = 1; 


n = length(Pnt);
M = eye(n-2); O = zeros(n-2,1);
A = [M O O] + [O 4*M O] + [O O M];
B = 3*Pnt(3:end,:) - 3*Pnt(1:end-2,:);

B = B - A(:,i)*Pdi;
B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

A(:,[i j]) = [];

X = inv(A)*B;
id = 1:n;   id([i j]) = [];

%Pd is the Tangent vector at all points 
Pd = zeros(n,2);
Pd(id,:) = X;
Pd(i,:) = Pdi;
Pd(j,:) = Pdj;

for i=1:n-1
    P2 = HermitInterpolation(Pnt(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
end
plot(Pnt(:,1),Pnt(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
xlim([-10 15])
ylim([-10 10])


function mouseDown(hObject, eventdata, handles)

global drawing;
global pID;
global points;
global points1;

cp = get(gca,'CurrentPoint');

if (cp(1,1)>-10) && abs(cp(1,1) <15)
    if (cp(1,2)>-10) && abs(cp(1,2) <10)
    drawing =1 ;
    end
end
plot (cp(1,1),cp(1,2) ,'r.')

if drawing
    pID = pID +1 ;
    points(1,pID) = cp(1,1);
    points(2,pID) = cp(1,2);
    
end


function mouseUp(hObject, eventdata, handles)
global X;
global drawing;
global points;
global pID;
global points1;
global a b c d;

%Two tangent vector defined at ith and jth point
if pID > 3
    cla
    points1 =points';
    
    Pdj = [a b];      j = pID;
    Pdi = [c d];      i = 1; 

    n = pID;
    M = eye(n-2); O = zeros(n-2,1);
    A = [M O O] + [O 4*M O] + [O O M];
    B = 3*points1(3:pID,:) - 3*points1(1:pID-2,:);

    B = B - A(:,i)*Pdi;
    B = B - A(:,j)*Pdj;   % ??? 2x2 matrix?

    A(:,[i j]) = [];

    X = inv(A)*B;
    id = 1:n;   id([i j]) = [];

    %Pd is the Tangent vector at all points 
    Pd = zeros(n,2);
    Pd(id,:) = X;
    Pd(i,:) = Pdi;
    Pd(j,:) = Pdj;
    for i=1:n-1
    P2 = HermitInterpolation(points1(i:i+1,:),Pd(i:i+1,:));
    plot(P2(:,1),P2(:,2),'r','Linewidth',2)
    hold on;            
    end
    
    plot(points1(:,1),points1(:,2),'bo','MarkerFaceColor','g','MarkerSize',6);
    
    xlim([-10 15])
    ylim([-10 10])
    drawing =0;


end

% --- Executes on button press in clear_fig.
function clear_fig_Callback(hObject, eventdata, handles)
% hObject    handle to clear_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
global drawing;
global pID;
global points;
global points1;
points = 0; pID = 0; points1 = 0; drawing = 0;
clc;


% --- Executes on button press in tangentbutton.
function tangentbutton_Callback(hObject, eventdata, handles)
% hObject    handle to tangentbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawing;
global pID;
global points;
global points1;
global X;

if(pID>2)
slope(:,1) = X(:,2)./X(:,1) ;
m = slope(:,1);
n= length(X);

for i = 1:n

o2 = points1(i+1,1)-1;
o3 =points1(i+1,2)-m(i);
o4 = points1(i+1,1)+1;
o5 = points1(i+1,2)+m(i);
%y11 = [points1(2,1)-1  points1(2,2)-y1]
line([points1(i+1,1)-1 points1(i+1,1)+1],[ points1(i+1,2)-m(i) points1(i+1,2)+m(i)])
plot(o2,o3,'bo')
plot(o4,o5,'bo')
end
drawing =0;
points =0;
points1=0;
pID  =0 ;

end


% --- Executes on selection change in textpoint1.
function textpoint1_Callback(hObject, eventdata, handles)
% hObject    handle to textpoint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns textpoint1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from textpoint1


% --- Executes during object creation, after setting all properties.
function textpoint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textpoint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textpoint2_Callback(hObject, eventdata, handles)
% hObject    handle to text28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text28 as text
%        str2double(get(hObject,'String')) returns contents of text28 as a double


% --- Executes during object creation, after setting all properties.
function text28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
