%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        ATLANTIS: Attractor Landscape Analysis Toolbox for        %
%              Cell Fate Discovery and Reprogramming               %
%                           Version 2.0.0                          %
%     Copyright (c) Biomedical Informatics Research Laboratory,    %
%      Lahore University of Management Sciences Lahore (LUMS),     %
%                            Pakistan.                             %
%                 http://biolabs.lums.edu.pk/birl)                 %
%                     (safee.ullah@gmail.com)                      %
%                  Last Modified on: 03-January-2018               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function states = generate_StateCombinations_randomSampling(myNetwork, sampleSize)

states = []; % will store randomly generated states
inp_states = [];

progressbar('Generating States. Please Wait...');
fixednodes = getappdata(0,'fixednodes');
fixednodes_size = size(fixednodes,2);
inputtype = getappdata(0,'inputdec');

if inputtype == 0
while size(states, 1) < sampleSize
    i = size(states, 1);
    diff = sampleSize - size(states, 1);
    progressbar(i/sampleSize);
    states = vertcat(states, randi([0 1], diff,myNetwork.NodeCount)); %#ok<AGROW>
    [a, b]=unique(states,'rows');   %#ok<ASGLU> % finding replicated rows %
    states = states(sort(b),:);     % removing replicated rows
end
progressbar(1);
%%% For Input states in decimals
%Generating network node states
else
nodes = myNetwork.NodeCount-fixednodes_size
while size(states, 1) < sampleSize
    i = size(states, 1);
    diff = sampleSize - size(states, 1);
    progressbar(i/sampleSize);
    states = vertcat(states, randi([0 1], diff,nodes)); %#ok<AGROW>
    [a, b]=unique(states,'rows');   %#ok<ASGLU> % finding replicated rows %
    states = states(sort(b),:);     % removing replicated rows
end

%Generating input node states
node1 = [];
for x = 1:fixednodes_size
    x;
    a = round(sampleSize * fixednodes(x));
    b = round(sampleSize * (abs(1-fixednodes(x))));
    a = ones(a,1);
    b = zeros(b,1);
    node1 = vertcat(a,b);
    inp_states = [inp_states,node1];
end

states = horzcat(states,inp_states);
progressbar(1);
end
end




