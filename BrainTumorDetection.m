function varargout = BrainTumorDetection(varargin)
% BRAINTUMORDETECTION MATLAB code for BrainTumorDetection.fig
%      BRAINTUMORDETECTION, by itself, creates a new BRAINTUMORDETECTION or raises the existing
%      singleton*.
%
%      H = BRAINTUMORDETECTION returns the handle to a new BRAINTUMORDETECTION or the handle to
%      the existing singleton*.
%
%      BRAINTUMORDETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAINTUMORDETECTION.M with the given input arguments.
%
%      BRAINTUMORDETECTION('Property','Value',...) creates a new BRAINTUMORDETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BrainTumorDetection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BrainTumorDetection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BrainTumorDetection

% Last Modified by GUIDE v2.5 02-Jun-2024 02:32:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BrainTumorDetection_OpeningFcn, ...
                   'gui_OutputFcn',  @BrainTumorDetection_OutputFcn, ...
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


% --- Executes just before BrainTumorDetection is made visible.
function BrainTumorDetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BrainTumorDetection (see VARARGIN)

% Choose default command line output for BrainTumorDetection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

cla(handles.axes1, 'reset');
cla(handles.axes2, 'reset');

% UIWAIT makes BrainTumorDetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = BrainTumorDetection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% UIWAIT makes BrainTumorDetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Executes on button press in Browse MRI Image.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img1 img2

% to open dialogbox
[path, nofile] = imgetfile();

if nofile
    msgbox('Image not found!!!','Error','warn');
    return
end

% read image 
img1 = imread(path);

% grayscale image conversion
img1 = im2double(img1);

% storing the image into img1 variable 
img2 = img1;

axes(handles.axes1);
imshow(img1);

title('Brain MRI', 'FontSize', 20, 'Color', [1, 1, 1]);
%title('\fontsize{15}\color[rgb]{0.255, 0.255, 0.255} Brain MRI')
%title('\fontsize{15}\color[rgb]{0.996, 0.592, 0.0} Brain MRI')


function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img1
axes(handles.axes2);
bw = im2bw(img1, 0.7);
label = bwlabel(bw);

stats = regionprops(label, 'Solidity', 'Area');
density = [stats.Solidity];
area = [stats.Area];
high_dense_area = density > 0.5;

% Set a minimum area threshold to filter out small areas
min_area_threshold = 100; 

if ~any(high_dense_area) || max(area(high_dense_area)) < min_area_threshold
    % No tumor detected
    imshow(img1);
    title('\fontsize{20}\color[rgb]{0.996, 0.0, 0.0} Tumor Not Detected');
    return;
end

max_area = max(area(high_dense_area));
tumor_label = find(area == max_area);
tumor = ismember(label, tumor_label);

se = strel('square', 5);
tumor = imdilate(tumor, se);

Bound = bwboundaries(tumor, 'noholes');

imshow(img1);
hold on

for i = 1:length(Bound)
    plot(Bound{i}(:,2), Bound{i}(:,1), 'y', 'linewidth', 1.75)
end

title('\fontsize{20}\color[rgb]{0.0, 0.996, 0.0} Tumor Detected!');

hold off
axes(handles.axes2)



% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('The end semester project of Digital Image Processing, done by Hajra Mehmood and Muhammad.','About US','help','modal');


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Version: 1.00','Version','help','replace');


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox(sprintf('Muhammmad: zamuranimuhammed@gmail.com\nHajra Mehood: hajramehmood24@gmail.com'),'Contact US','help','non-modal');
