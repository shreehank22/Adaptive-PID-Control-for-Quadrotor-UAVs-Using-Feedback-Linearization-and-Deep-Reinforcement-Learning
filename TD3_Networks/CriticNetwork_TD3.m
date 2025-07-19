% We employ the concept of dual networks for the critic architecture
% State Path
statePath = [
    featureInputLayer(obsDims, 'Normalization', 'none', 'Name', 'stateInLyr')
    fullyConnectedLayer(128, 'Name', 'fc_state')
    layerNormalizationLayer('Name', 'ln_state')
    reluLayer('Name', 'relu_state')
];

% Action Path
actionPath = [
    featureInputLayer(actionDims, 'Normalization', 'none', 'Name', 'actionInLyr')
    fullyConnectedLayer(128, 'Name', 'fc_action')
    layerNormalizationLayer('Name', 'ln_action')
    reluLayer('Name', 'relu_action')
];

% Common Path
commonPath = [
    additionLayer(2, 'Name', 'add')
    fullyConnectedLayer(128, 'Name', 'fc_common')
    layerNormalizationLayer('Name', 'ln_common')
    reluLayer('Name', 'relu_common')
    fullyConnectedLayer(1, 'Name', 'q_output')
];

% Critic 1
criticLG1 = layerGraph();
criticLG1 = addLayers(criticLG1, statePath);
criticLG1 = addLayers(criticLG1, actionPath);
criticLG1 = addLayers(criticLG1, commonPath);
criticLG1 = connectLayers(criticLG1, 'relu_state', 'add/in1');
criticLG1 = connectLayers(criticLG1, 'relu_action', 'add/in2');
criticNet1 = dlnetwork(criticLG1);

% Critic 2 (Twin Q Network with renamed layers)
criticLG2 = replaceLayer(criticLG1, 'fc_common', ...
    fullyConnectedLayer(128, 'Name', 'fc_common2'));
criticLG2 = replaceLayer(criticLG2, 'ln_common', ...
    layerNormalizationLayer('Name', 'ln_common2'));
criticLG2 = replaceLayer(criticLG2, 'q_output', ...
    fullyConnectedLayer(1, 'Name', 'q_output2'));
criticNet2 = dlnetwork(criticLG2);

% Wrap Critic Functions
critic1 = rlQValueFunction(criticNet1, obsInfo, actionInfo, ...
    'ObservationInputNames', 'stateInLyr', ...
    'ActionInputNames', 'actionInLyr');

critic2 = rlQValueFunction(criticNet2, obsInfo, actionInfo, ...
    'ObservationInputNames', 'stateInLyr', ...
    'ActionInputNames', 'actionInLyr');
