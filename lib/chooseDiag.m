function reply = chooseDiag( prompt )
% Construct a questdlg with two options
choice = questdlg( prompt, ...
	'Choices', ...
	'Yes','No','Yes');
% Handle response
switch choice
    case 'Yes'
        reply = 1;
    case 'No'
        reply = 2;
end

end

