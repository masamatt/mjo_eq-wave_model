function H0Vec = genH0(yHatVec)
% GENH0 - "gen"erates a vector of H values for n=0, all yHat values.
%         (function). This function takes a vector of yHat values,
%         yHatVec = [-yHatMax..yHatMax], and returns a 1-D array of H
%         values for each yHat at n=0, where H are the "script-H"
%         polynomials.
%
% FILE: genH0.m
% AUTHOR: Matt Masarik
% DATE: June 14, 2005
% MODIFIED: N/A
% CALL SYNTAX: H0Vec = genH0(yHatVec)
%              yHatVec = [-yHatMax..yHatMax] (1-D array) []
% PRE: None
% POST: A 1-D array H0Vec = H0Vec(yIndex) is returned.


% Entry statement
disp('  genH0.m function           : [H_0(yHat)] - generate n=0 H structure functions')

% use array operation to calculate H0 
H0Vec = pi^(-1/4)*exp((-1/2)*yHatVec.^2);


% Exit statement
% disp('Exiting genH0.m function.')
% disp(' ')

% END

