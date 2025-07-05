% MATLAB Code for the TD3 actor network
actorLayers = [
    featureInputLayer(obsDims, 'Normalization', 'none', 'Name', 'state_input')

    fullyConnectedLayer(128, 'Name', 'fc1')
    layerNormalizationLayer('Name', 'ln1')
    reluLayer('Name', 'relu1')

    fullyConnectedLayer(128, 'Name', 'fc2')
    layerNormalizationLayer('Name', 'ln2')
    reluLayer('Name', 'relu2')

    fullyConnectedLayer(actionDims, 'Name', 'fc_out')
    tanhLayer('Name', 'tanh_out')

    scalingLayer('Name', 'scale_out', ...
        'Scale', (gainMax - gainMin)/2, ...
        'Bias',  (gainMax + gainMin)/2)
];

actorNet = dlnetwork(layerGraph(actorLayers));

actor = rlContinuousDeterministicActor(actorNet, obsInfo, actionInfo, ...
    'ObservationInputNames', 'state_input');