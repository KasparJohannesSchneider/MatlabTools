function saveFigPDF(filename,fig)
%SAVEFIGPDF Sets up the style of a figure ans saves it as .pdf and .fig
%**************************************************************************
% https://github.com/KasparJohannesSchneider/MatlabTools
%
% This function sets up a figure visually and saves it as a .pdf and .fig
% file.
% The PDF file uses vector graphics and is optimised to be used in a
% LaTex document.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: mrc18jsr, Kaspar Johannes Schneider, kaspar.sch@outlook.com
%     2019-11-30 v1.0: Initial version
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% IN:
%****
%- filename:        File name for the pdf and fig file without extension
%- fig (optional):  Handle for the figure if not specified gcf will be used
%
%
% OUT:
%****
% Nothing
%
% Minimal working example:
%%%%%%%%%%%%%%%%%%%%%%%%%%
% >> peaks                  % Create an example plot
% >> saveFigPDF('peaks')    % Save the figure as .pdf and .fig
% --> Creates the file peaks.pdf
% --> Creates the file peaks.fig
%
% MIT License
%%%%%%%%%%%%%%
%
% Copyright (c) 2019 Kaspar Johannes Schneider
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE
%
%**************************************************************************

% use gcf if no fig is specified
if nargin < 2
    fig = gcf;
end

% Get all the children of the figure
children = get(fig,'children');

% Loop through the children
for i=1:length(children)
    % Select current axis
    child = children(i);
    
    % Test if child is an Axis
    if isa(child, 'matlab.graphics.axis.Axes')
        % Grid
        grid(child, 'on')
        grid(child, 'minor')
        
        % Tick labels
        child.XAxis.FontSize = 14;
        child.YAxis.FontSize = 14;
        child.ZAxis.FontSize = 14;
        child.TickLabelInterpreter = 'latex';
        
        % Axis labels
        %************
        % X
        child.XAxis.Label.FontSize = 18;
        child.XAxis.Label.Interpreter = 'latex';
        child.XAxis.Label.String = bold(child.XAxis.Label.String);
        
        % Y
        child.YAxis.Label.FontSize = 18;
        child.YAxis.Label.Interpreter = 'latex';
        child.YAxis.Label.String = bold(child.YAxis.Label.String);
        
        % Z
        child.ZAxis.Label.FontSize = 18;
        child.ZAxis.Label.Interpreter = 'latex';
        child.ZAxis.Label.String = bold(child.ZAxis.Label.String);
        
        % Title
        child.Title.FontSize = 24;
        child.Title.Interpreter = 'latex';
        child.Title.String = bold(child.Title.String);
    else
        % Test if child is a Legend
        if isa(child, 'matlab.graphics.illustration.Legend')
            child.Interpreter = 'latex';
            child.FontSize = 18;
        end
    end
end

% Ensure that vector graphics are used
fig.Renderer = 'Painters';

% Landscape seems to work best for most of the plots
set(fig,'PaperOrientation','landscape');

% Save the figure as a PDF
print(fig, strcat(filename, ".pdf"),...
    '-dpdf', '-fillpage')

% Save the figure as a Matlab .fig file
savefig(fig, strcat(filename, ".fig"))
end

function bldStr = bold(str)
%BLDSTR Makes a string bold for LaTex by surrounding it with \textbf{str}
%**************************************************************************
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: mrc18jsr, Kaspar Johannes Schneider, kaspar.sch@outlook.com
%     2019-11-30: Initial version
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% IN:
%****
%- str: Input string
%
%
% OUT:
%****
%- bldStr: The input string as \textbf{str}
%
% Minimal working example:
%%%%%%%%%%%%%%%%%%%%%%%%%%
% >> str = "Hello World";
% >> bldStr = strcat("\textbf{", str, "}");
% >> disp(bldStr)
%     "\textbf{Hello World}"
%
%**************************************************************************

% Surround the input string with \textbf{}
bldStr = strcat("\textbf{", str, "}");

end
