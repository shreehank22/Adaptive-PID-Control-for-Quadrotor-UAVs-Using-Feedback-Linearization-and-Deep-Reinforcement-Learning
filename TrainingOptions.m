% Training Module
maxEpisodes = 5000;
maxSteps = 100;  % 10 seconds per episode at 0.1s sample time

trainOpts = rlTrainingOptions(...
    'MaxEpisodes', maxEpisodes, ...
    'MaxStepsPerEpisode', maxSteps, ...
    'ScoreAveragingWindowLength', 100, ...
    'Verbose', false, ...
    'Plots', 'training-progress', ...
    'StopTrainingCriteria', 'AverageReward', ...
    'StopTrainingValue', 0, ...
    'SaveAgentCriteria', 'EpisodeReward', ...
    'SaveAgentValue', -100, ...
    'SaveAgentDirectory', 'saved_agents_td3_pid');