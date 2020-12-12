function [ slash, splitter ] = OSCompatibility( )

% PLEASE CHANGE VALUE OF OS ACCORDING TO THE OPERATING SYSTEM
%   OS = 0 for Windows OS
%   OS = 1 for Mac or Linux-based OS
OS = 0;

if OS == 0
    slash = '\';
    splitter = ';';
elseif OS == 1
    slash = '/';
    splitter = ',';
end

end

