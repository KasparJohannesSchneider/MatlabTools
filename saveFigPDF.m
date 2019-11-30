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

% Get all the axes
axes = get(fig,'children');

% Loop through the axes
for i=1:length(axes)
    % Select current axis
    ax = axes(i);
    
    % Grid
    grid(ax, 'minor')
    
    % Tick labels
    ax.XAxis.FontSize = 14;
    ax.YAxis.FontSize = 14;
    ax.ZAxis.FontSize = 14;
    ax.TickLabelInterpreter = 'latex';
    
    % Axis labels
    %************
    % X
    ax.XAxis.Label.FontSize = 18;
    ax.XAxis.Label.Interpreter = 'latex';
    ax.XAxis.Label.String = bold(ax.XAxis.Label.String);
    
    % Y
    ax.YAxis.Label.FontSize = 18;
    ax.YAxis.Label.Interpreter = 'latex';
    ax.YAxis.Label.String = bold(ax.YAxis.Label.String);
    
    % Z
    ax.ZAxis.Label.FontSize = 18;
    ax.ZAxis.Label.Interpreter = 'latex';
    ax.ZAxis.Label.String = bold(ax.ZAxis.Label.String);
    
    % Title
    ax.Title.FontSize = 24;
    ax.Title.Interpreter = 'latex';
    ax.Title.String = bold(ax.Title.String);
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
