function str = mat2lat(A,bracket)
% MAT2LAT Matrix to LaTex math mode array conversion
% https://github.com/KasparJohannesSchneider/MatlabTools
%
% Author: KJS: Kaspar Johannes Schneider
%              kaspar.sch@outlook.com
%
% Version: 1.0, KJS, 09 Oct 2019, Initial version
%          1.1, KJS, 21 Oct 2019, Added proper alignment for complex matrices
%
% Examples
%%%%%%%%%%%
% >> str = mat2lat(eye(2,3)*10000)
% str = "% Generated using mat2lat.m v1.0
%        % https://github.com/KasparJohannesSchneider/mat2lat
%        \left[\begin{array}{ccc}
%            {10000} & {0}     & {0} \\
%            {0}     & {10000} & {0}
%        \end{array}\right]"
%
% >> syms a t;
% >> a = cos(t);
% >> str = mat2lat([a,0,0;0,a,0;0,0,1])
% str = "% Generated using mat2lat.m v1.0
%        % https://github.com/KasparJohannesSchneider/mat2lat
%        \left[\begin{array}{ccc}
%            {cos(t)} & {0}      & {0} \\
%            {0}      & {cos(t)} & {0} \\
%            {0}      & {0}      & {1}
%        \end{array}\right]
%
% >> str = mat2lat(eye(3)*10000,'(')
% str = "% Generated using mat2lat.m v1.0
%        % https://github.com/KasparJohannesSchneider/mat2lat
%        \left(\begin{array}{ccc}
%            {10000} & {0}     & {0}     \\
%            {0}     & {10000} & {0}     \\
%            {0}     & {0}     & {10000}
%        \end{array}\right)"
%
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

% Select the chosen brackets
if nargin>1 % User made a selection
    switch bracket
        case {'none','n','-','.','',' ','_'}
            brktO = '.';
            brktC = '.';
        case '('
            brktO = '(';
            brktC = ')';
        case '['
            brktO = '[';
            brktC = ']';
        case '{'
            brktO = '{';
            brktC = '}';
        case '|'
            brktO = '|';
            brktC = '|';
        otherwise
            brktO = '[';
            brktC = ']';
    end
else % No selection by the user
    brktO = '[';
    brktC = ']';
end

% Size of Matrix
m = length(A(:,1)); % m rows
n = length(A(1,:)); % n columns
is_complex = norm(imag(A)) > 0;

% Add comment
str = "% Generated using mat2lat.m v1.1" + newline +...
    '% https://github.com/KasparJohannesSchneider/mat2lat';

% Add begin array
str = str + newline + '\left'+brktO + '\begin{array}{';

% Column alignment
if is_complex % If complex, align on sign
    str = str + "*{" + num2str(n) +...
        "}{r@{\mskip\medmuskip}c@{\mskip\medmuskip}l}";
else
    for i=1:n
        str = str + "c";
    end
end
str = str + "}" + newline;

colWidth = zeros(1,n); % Maximum column with for alignment
entries = strings(m,n); % Contents of the matrix entries

% Get entries and column widths
for i=1:m % Loop through rows
    for j=1:n % Loop through columns
        if isnumeric(A(i,j))
            if is_complex % Complex
                if imag(A(i,j))<0 % Get the sign of imag(A(i,j))
                    sign ="} &-& {";
                else
                    sign = "} &+& {";
                end
                entries(i,j) = real(A(i,j)) + sign +...
                    abs(imag(A(i,j)))+"j";
            else % Real
                entries(i,j) = A(i,j);
            end
        else % Special case for symbolic matrices
            entries(i,j) = char(A(i,j));
        end
        
        % Remember the maximum column width
        colWidth(j) = max(colWidth(j),strlength(entries(i,j)));
    end
end

% Assemble the LaTex array
for i=1:m % Loop through rows
    str = str + "    "; % Indentation
    for j=1:n % Loop through columns
        
        str = str + '{' + entries(i,j) + '}'; % Add entry
        
        % Add spaces for alignment
        str = str + blanks(colWidth(j)-strlength(entries(i,j)));
        
        if j ~= n % Column termination if not last column
            str = str + ' & ';
        end
    end
    if i ~= m % Line termination if not last row
        str = str + ' \\' + newline;
    end
end

% End array
str = str + newline + '\end{array}\right' + brktC;
end

