function [N, A, time, xpos, vel] = HPSTL(b_u,dSingnificanceLevel,delta)
%Inputs:
%       b_u:                    Probability Thresshold,
%       dSingnificanceLevel:    Desired sig. level,
%       delta:                  Specification threshold.
% Outputs:
%       A:                      Assertation,
%       N:                      Sampling cost,
%       time:                   Required time to run the simulink model

a = [0,b_u];
b = [b_u,1];
sigLevel = 1;
time = 0;
s = [];
xpos = [];
vel = [];
j = 0;
while sigLevel > dSingnificanceLevel
    j = j+1;
    %% Sampling
    T1=tic;
    h = normrnd(-0.3,0.18);
    while h<-1.2 || h>=0.59
        h = normrnd(-0.3,0.18);
    end
    xpos(j) = h;
    set_param('CM/CM System/Pos','InitialCondition',num2str(h));
    
    h = normrnd(0,0.21);
    while abs(h)> 1
        h = normrnd(0,0.21);
    end
    vel(j) = h;
    set_param('CM/CM System/Vel','InitialCondition',num2str(h));
    simOut = sim('CM','SaveTime','on','TimeSaveName','tout');
    time = time + toc(T1);
    %%
    st = (simOut.tout(end) < delta); % spesification
    s = [s;st];
    Nk = length(s); % sampling cost
    T = sum(s);
    if T / Nk < b_u
        z = 1; % interval [0 b]
    else
        z = 2; % interval [b 1]
    end
    if T == 0 % Updating Alpha
        Alpha = (1 - a(z))^Nk - (1 - b(z))^Nk;
    elseif T == Nk
        Alpha = b(z)^Nk-a(z)^Nk;
    else
        alpha_a = T;
        beta_a = Nk - T +1;
        alpha_b = T +1;
        beta_b = Nk - T;
        pd_a = makedist('Beta','a',alpha_a,'b',beta_a);
        pd_b = makedist('Beta','a',alpha_b,'b',beta_b);
        Alpha = cdf(pd_b,b(z)) - cdf(pd_a,a(z));
    end
    sigLevel = 1 - Alpha; % Calculation of sig. level
end
if (T / Nk) < b_u
    A = 1;
else
    A = 0;
end
N = Nk;

