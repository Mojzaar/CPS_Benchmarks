clc;
clear
%% parameters
rng(5000)

epsilon = [0.5, 0.7, 0.9];% are the coresponding values with (1-epsilon) in the paper
dSingnificanceLevel = [0.01, 0.05];% are the corresponding values with  desired significance level
delta = [1.1, 1.05, 1];% are the corresponding values with the specification threshold
number_of_simulation = 100;% total number of repeat
%% Outputs:
% Algorithm result (Ans.)
% SMC algorithm execution time (Time (s)) = whole simulation time
% consumption - time to run the Simulink model
% Sampling cost (Sam.)
% Accuracy of the algorithm (Acc.)
%%

load_system('narmaSimIAE')
j = 0;
for i_e = 1 : length(epsilon)
    for i_s = 1 : length(dSingnificanceLevel)
        for i_d = 1 : length(delta)
            j = j +1;
            Pr(j).delta = delta(i_d);% Specification threshold
            Pr(j).epsilon = epsilon(i_e);% Probability threshold
            Pr(j).dSigLev = dSingnificanceLevel(i_s);% Desired significance level
            for i = 1 : number_of_simulation
                [N, A, exTimeAverage, totalTime]= HPSTL(epsilon(i_e),dSingnificanceLevel(i_s),delta(i_d));
                Pr(j).time(i) = totalTime;% Sampling + execution of the algorithm
                Pr(j).N(i) = N; % Sampling cost
                Pr(j).A(i) = A; % The obtained assertation by the propose algorithm
                Pr(j).exTimeAverage(i) = exTimeAverage; % Total sampling time for the given parameters
                Pr(j).algTime(i) = totalTime - exTimeAverage;
            end
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
            fprintf('The input values are delta, 1-epsilon, alpha, and number of simulation (%1.1f, %1.2f, %1.2f, %d), respectively.\n',delta(i_d),epsilon(i_e), dSingnificanceLevel(i_s), number_of_simulation)
            fprintf('The inputs are accuracy, sampling cost, SMC execution time, and the algorithm result (%1.2f, %1.1e, %1.1e, %s), respectively.\n',Pr(j).acc, mean(Pr(j).N), mean(Pr(j).algTime), Pr(j).res)
        end
        
    end
end
