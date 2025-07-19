%% === Setup Parameters ===
num_Axes = 4;                     % yaw, pitch, roll, altitude
obs_PerAxis = 4;                  % e, de/dt, ∫e, and output states
gains_PerAxis = 3;                % PID Gains

obsDims = num_Axes * obs_PerAxis;      % 16
actionDims = num_Axes * gains_PerAxis; % 12

gainMin = 0.0;
gainMax = 100.0;

%% === Define Observation and Action Specs ===
obsInfo = rlNumericSpec([obsDims 1], ...
    'LowerLimit', -inf(obsDims,1), ...
    'UpperLimit',  inf(obsDims,1));
obsInfo.Name = 'PID Observations';
obsInfo.Description = 'e, de/dt, ∫e, state for yaw, pitch, roll, altitude';

actionInfo = rlNumericSpec([actionDims 1], ...
    'LowerLimit', gainMin, ...
    'UpperLimit', gainMax);
actionInfo.Name = 'PID Gains';
actionInfo.Description = 'Kp, Ki, Kd for yaw, pitch, roll, altitude';
%% === Environment ===
mdl = 'FBL_ON_UAV_Final';
env = rlSimulinkEnv(mdl, [mdl '/RL Agent'], obsInfo, actionInfo);