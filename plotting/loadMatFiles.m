%
% loadMatFiles.m
%
% PURPOSE:  load coordinates and output field variables from .mat files.
%
%
%


LOADVARS=0;                % 0: true,  1: false

if LOADVARS == 0
    disp('Loading variables...')
    
    % load y
    disp('Loading y coordinate...')
    load coord_y.mat
    disp('Finished loading y coordinate.')
    disp(' ')

    % load xi 
    disp('Loading xi coordinate...')
    load coord_xi.mat
    disp('Finished loading xi coordinate.')
    disp(' ')

    % load u(yHat,xi)
    disp('Loading u field...')
    load field_u.mat
    disp('Finished loading u field.')
    disp(' ')

    % load v(yHat,xi)
    disp('Loading v field...')
    load field_v.mat
    disp('Finished loading v field.')
    disp(' ')

    % load phi(yHat,xi)
    disp('Loading phi field...')
    load field_phi.mat
    disp('Finished loading phi field.')
    disp(' ')

    % load omegaM(yHat,xi)
    disp('Loading omegaM field...')
    load field_omegaM.mat
    disp('Finished loading omegaM field.')
    disp(' ')

    % load q(yHat,xi)
    disp('Loading q field...')
    load field_q.mat
    disp('Finished loading q field.')
    disp(' ')
end


%END

