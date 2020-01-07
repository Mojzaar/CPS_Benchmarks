clear;
clc;

load('cont.mat')
load_system('CM')
rng(6)
%% Inputs:
epsilon = [0.3 0.6 0.9]; % are the coresponding values with (1-epsilon) in the paper
dSingnificanceLevel = [0.05,0.01]; % are the corresponding values with  desired significance level
delta = [4 7 10]; % are the corresponding values with the specification threshold
number_of_simulation = 100; % total number of repeat
%% Outputs:
% Algorithm result (Ans.)
% SMC algorithm execution time (Time (s)) = whole simulation time
% consumption - time to run the simulink model
% Sampling cost (Sam.)
% Accuracy of the algorithm (Acc.)
%%
j = 0;
Pr(1).rng = rng;

for i_b = 1 : length(epsilon)
    for i_s = 1 : length(dSingnificanceLevel)
        for i_d = 1 : length(delta)
            j = j +1;
            Pr(j).delta = delta(i_d); % Specification threshold
            Pr(j).epsilon = epsilon(i_b); % Probability threshold
            Pr(j).dSigLev = dSingnificanceLevel(i_s); % Desired significance level
            for i = 1 : number_of_simulation
                tic
                [N, A,time_sml,xpos, vel] = HPSTL(epsilon(i_b),dSingnificanceLevel(i_s),delta(i_d));
                Pr(j).algTime(i) = toc - time_sml;
                data(i).xpos = xpos;
                data(i).vel = vel;
                Pr(j).A(i) = A;%The obtained assertation by the propose algorithm
                Pr(j).N(i) = N;% Sampling cost
            end
            save(sprintf('data%d.mat',j),'data', 'Pr')
            if sum(Pr(j).A)/length(Pr(j).A) >0.5 % Algorithm result
                Pr(j).res = 'True' ;
            else
                Pr(j).res = 'False';
            end
            if sum(Pr(j).A)/length(Pr(j).A) >0.5 % Algorithm accuracy
                Pr(j).acc = sum(Pr(j).A)/length(Pr(j).A);
            else
                Pr(j).acc = 1 - sum(Pr(j).A)/length(Pr(j).A);
            end
            fprintf('The input values are delta, 1-epsilon, alpha, and number of simulation (%1.1f, %1.2f, %1.2f, %d), respectively.\n',delta(i_d),epsilon(i_b), dSingnificanceLevel(i_s), number_of_simulation)
            fprintf('The inputs are accuracy, sampling cost, SMC execution time, and the algorithm result (%1.2f, %1.1e, %1.1e, %s), respectively.\n',Pr(j).acc,mean(Pr(j).N), mean(Pr(j).algTime),Pr(j).res)
        end
    end
end
