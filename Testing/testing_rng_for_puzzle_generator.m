% testing to see if the distribution of rows is even in my usage of the
% randperm function
counts = zeros(1,9);
countscol = zeros(1,9);
for i = 1:100000
    rng("shuffle");
    cells = randperm(81,9);
        for i = 1:9
            row = ceil(cells(i)/9);
            col = mod(cells(i),9);
            counts(row) = counts(row) + 1;
            countscol(col) = countscol(col) + 1;
        end
end
disp(counts)
disp(countscol)

% result was 10053 10059 9827 10031 9978 10130 10031 10047 9844
% therefore it is random enough for its intended purpose