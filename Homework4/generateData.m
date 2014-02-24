numEntries = 2000;
features = rand([numEntries 2]);
labels = zeros([numEntries 1]);

for row = 1:numEntries
    %if above line y = 1.3x - 0.2
    if( -1.3*features(row,1) + features(row,2) + 0.2 > 0) 
       labels(row) = 1; 
    end
end