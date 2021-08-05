%% MA 202 Course Project: Numerical Analysis of the Google PageRank Algorithm
% Indian Institute of Technology, Gandhinagar

% Date: 08/05/2021

% Authors:

% Aadesh Desai 19110116
% Eshan Gujarathi 19110082
% Hiral Sharma 19110016
% Sanjay Venkitesh 19110200

% Instructors:

% Prof. Chetan Pahlajani
% Prof. Dilip Sundaram
% Prof. Satyajit Pramanik


%% Taking an example of 6 webpages to demostrate the results obtained using PageRank
clear;
clc;
format shortg

NumberOfNodes = 6;
NumberOfLinks = floor(nchoosek(NumberOfNodes,2));

% Creating a graph randomly based on number of links and nodes
temp = randi(NumberOfNodes, NumberOfLinks, 2);
temp(diff(temp,[],2)==0, :) = [];   %remove self-loops
s = temp(:,1); 
t = temp(:,2);

G = digraph(s, t);
G = simplify(G);        % To remove repeated links

lengthNodes = NumberOfNodes;
G.Nodes.InDegree = indegree(G);
G.Nodes.OutDegree = outdegree(G);

% Plotting the graph that was created 
p = plot(G);
p.MarkerSize = 7;
p.NodeColor = 'r';
title("Graph representing the links between webpages", "interpreter", "Latex");


% Displaying the number of links from each node
disp("Number of incoming and outgoing links for each node: ");
disp(G.Nodes);

A = zeros(lengthNodes,lengthNodes);

s = s';
t = t';
numberOfLinks = size(s,2);

%------Determining the matrix A required for the PageRank Algorithm--------

for i = 1:numberOfLinks
    A(t(i),s(i)) = 1/(G.Nodes.OutDegree(s(i)));
end

% Handling the exception case where number of OutLinks for a node is 0

sumColumn = sum(A);
for i = 1:lengthNodes
    if sumColumn(i) == 0                    % Checking if outlinks are 0
        for j =1:lengthNodes
            if i ~=j
                A(j, i) = 1/(lengthNodes -1);    % Distributing outlinks equally to all other nodes 
            end
        end
    end
end

% Displaying the vector A for the given graph
disp("The matrix A of the Graph is ");
disp(A);

eps = 1e-12;            % Choosing epsilon for termination of the algorithm
eps = eps/lengthNodes;

damp_fac = 0.85;        % Setting the damping factor 

% Calling the function that solves the Equation
[r, count, t] = pageRank(A, lengthNodes, damp_fac, eps);

% Displaying the results
disp("Final Rank Vector is =");
disp(r);

X= ['Number of iterations for convergence = ', num2str(count)];
disp(X);

X= ['Execution time for solving the equation = ', num2str(t)];
disp(X);


%% Performance Analysis by Changing the Number of Webpages (Nodes in the Graph)

numberOfPages = [4:2:100];      % Array specifying sizes of different graphs
numberOfIterations= [];         % Array for number of iterations for convergence
executionTime = [];             % Array for storing execution time

n = length(numberOfPages);

for k=1:n
    
    % We perform the algorithm 3 times for a network of fixed size and take
    % the mean execution time and number of iterations for convergence
    
    time = zeros(1,4);
    iteration = zeros(1,4);
    
    for t = 1:4
        
        % Creating a random graph of networks with fixed number of nodes
        NumberOfNodes = numberOfPages(k);
        NumberOfLinks = floor(nchoosek(NumberOfNodes,2));

        temp = randi(NumberOfNodes, NumberOfLinks, 2);
        temp(diff(temp,[],2)==0, :) = [];       %remove self-loops
        s = temp(:,1); 
        t = temp(:,2);

        G = digraph(s, t);
        G = simplify(G);            % Removing repeated loops
        
        % Determining number of links in the graph
        lengthNodes = NumberOfNodes;
        G.Nodes.InDegree = indegree(G);
        G.Nodes.OutDegree = outdegree(G);
        
        % Determiniing the Matrix A needed for the PageRank algorithm
        A = zeros(lengthNodes,lengthNodes);

        s = s';
        t = t';
        
        numberOfLinks = size(s,2);
        for i = 1:numberOfLinks
            A(t(i),s(i)) = 1/(G.Nodes.OutDegree(s(i)));
        end

        for i = 1:numberOfLinks
           A(t(i),s(i)) = 1/(G.Nodes.OutDegree(s(i)));
        end

        % Handling the exception case where number of OutLinks for a node is 0
        sumColumn = sum(A);
        for i = 1:lengthNodes
            if sumColumn(i) == 0
                for j =1:lengthNodes
                    if i ~=j
                        A(j, i) = 1/(lengthNodes -1);
                    end
                end
            end
        end
        
        % Setting epsilon for convergence
        eps = 1e-12;
        eps = eps/lengthNodes;
        
        % Setting the value of the dapming factor
        damp_fac = 0.85;
        
        % Ranking the pages by calling the PageRank function
        [r1, count1, t1] = pageRank(A, lengthNodes, damp_fac, eps);
        
        % Storing the values of execution time and number of iterations for
        % convergence
        time(t) = t1;
        iteration(t) = count1;
    end
    
    % Taking mean of the four values for plotting
    meanTime = 0;
    meanIteration = 0;
    for j =1:4
        meanTime = meanTime + time(j)/4;
        meanIteration = meanIteration + iteration(j)/4;
    end
    executionTime(k) =  meanTime;
    numberOfIterations(k) = meanIteration;
    
    
end

% Plotting the results obtained
figure;
sgtitle("Performance of the PageRank Algorithm", "interpreter", "Latex");

subplot 121
bar(numberOfPages, numberOfIterations, 'FaceColor', '#EDB120');
title("Number of Iterations for convergence", "interpreter", "Latex");
xlabel("Number of webpages ranked", "interpreter", "Latex");
ylabel("Number of iterations needed for convergence", "interpreter", "Latex");
grid on;

subplot 122
bar(numberOfPages, executionTime,'FaceColor', '#D95319')
title("Exectution Time", "interpreter", "Latex");
xlabel("Number of webpages ranked", "interpreter", "Latex");
ylabel("Execution time to determine the rank vector", "interpreter", "Latex");
grid on;


 
%% pageRank function that solves the equation Ar = r and evaluates rank vector r
function [r, count, time] = pageRank(A, m, d, eps)
    % A = matrix corresponding to the Graph
    % m = number of nodes
    % d = damping factor (generally set to 0.85)
    % eps = absolute error for convergence
    
    % r = rank 
    
    tic;
   
    % Initial value of the PageRank vector
    r = ones(m, 1);
    r = 1/m .* r;
    count = 0;              % Number of iterations for convergence
    while true
        r_prev = r;
        r = d*A*r_prev + (1-d)/m;      % Updating the rank vector based on the previous value
        
        % Checking for convergence
        if count > 0
             % Convergence criteria
             s1 = 0;
            
             for j =1: m
                 s1 = s1 + abs(r(j) - r_prev(j));
             end
             if(s1)< eps
                    break
            end
        end
        count = count + 1;      % Counting the number of iterations
    end
 
  time = toc;                   % Total execution time for convergence
end