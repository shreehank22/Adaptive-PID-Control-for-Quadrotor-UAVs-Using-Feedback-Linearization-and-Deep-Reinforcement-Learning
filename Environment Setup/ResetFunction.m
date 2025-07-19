%Set the variables hRef, fRef and hRef_new in the simulink model
function in = localResetFcn(in, mdl)
    hRef = 5 * rand;  % step height
    fRef = 3 * rand;  % step time
    hRef_new = hRef+0.1;
    refBlock = [mdl '/reference'];
    cmpblock = [mdl,'/cmp1'];
    % Set "After" (step height) and "Time" (step onset)
    in = setBlockParameter(in, refBlock, 'After', num2str(hRef));
    in = setBlockParameter(in, refBlock, 'Time', num2str(fRef));
    in = setBlockParameter(in, cmpblock, 'const', num2str(hRef_new));
end