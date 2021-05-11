addpath(genpath(pwd));
% load('G1.mat')
% d = length(Casos);
% len = 3;
% ydata = zeros(len*3,d);
% j = 1;
% close all
% figure
% title("Datos reales")
Grupos =["Migration","Original"];
N = length(Grupos);
% for i = 1:2
%     load(strcat('G', int2str(i), '.mat'));
%     ydata(3*(i-1)+1,:) = Casos - Muertos - Recuperados;
%     ydata(3*(i-1)+2,:) = Muertos; 
%     ydata(3*(i-1)+3,:) = Recuperados; 
% 
%     subplot(4, 3, 3*(i-1)+1)
%     plot(ydata(3*(i-1)+1,:))
%     ylabel(Grupos(i))
%     xlabel("Tiempo")
%     subplot(4, 3, 3*(i-1)+2)
%     plot(ydata(3*(i-1)+2,:))
%     xlabel("Tiempo")
%     subplot(4, 3, 3*(i-1)+3)
%     plot(ydata(3*(i-1)+3,:))
%     xlabel("Tiempo")
% end

VarNames={'N_0','E^2_0','P_0','J_1','J_{L}','D','R_j','RJ_L'};

OutNames={'S_f','S_q','E_f','E_q','L_f','L_q','L','H','J','D',...
        'R','T','RJH','RJL','RJ','Tot','JH','JL','J_{~P}','J_{P}','S in',...
        'R in','E in','P^H in','P^L in','L in','S out','R out','E out','P^H out','P^L out','L out','in sum'};

ParNames={'\beta_L','\beta_T', '\beta_P', '\phi_{EP}',...
            '\lambda_{fq}', '\vartheta_E','\gamma_L', 'k_L',...
            'k_P', '\phi_T','\lambda_{qf}', '\psi_e', '\phi_{PH}',...
            '\delta','m','\eta_L', '\vartheta_P','\gamma_H', 'z',...
            '\phi_{PL}','\eta_\vartheta','nons','a_L','b_L',...
            'a_\mu','b_\mu','\mu','a_H','b_H','\nu','time'};

FullNames = [VarNames,ParNames];
  
model = 'ChimeraModeldesagregados';

Range1 = [
    50372424 50372424;      % N_0
    94.1545 94.1545;        % E^2_0
    269.2043 269.2043;      % P_0
    0 0;                    % J_1
    0 0;                    % J_L
    0 0;                    % D
    0 0;                    % R_j
    0 0;                    % RJ_L
    ];

% Range2=[
%     0.7 0.9;    % beta_L
%     0   1;      % beta_T          
%     0.2 0.6;    % beta_P
%     0	8;      % phi_{EP}
%     0	1;      % lambda_{fq}
%     0	1;      % vartheta_E
%     0   1;      % gamma_L
%     1   10;     % k_L
%     1   1;      % k_P
%     1	8;      % phi_T
%     0	1;      % lambda_{qf}
%     0	0;      % psi_e
%     0	3;      % phi_{PH}
%     0   0.15;   % delta
%     0   0;      % Migration input
%     0   1;      % eta_L
%     0   1;      % vartheta_P
%     0   1;      % gamma_H 
%     0   30;     % z 
%     0   3;      % phi_{PL}
%     0   1;      % eta_vartheta
%     0   0;      % nons
%     1   15;     % a_L
%     1   15;     % b_L
%     1   15;     % a_mu
%     1   15;     % b_mu
%     0   1;      % mu
%     1   15;     % a_H
%     1   15;     % b_H
%     0  500;     % nu
%     41  41      % m
%     ];

Range2=[
     0.8331 0.8331;    % beta_L
     0.0441   0.0441;  % beta_T          
     0.3237 0.3237;    % beta_P
     0.2307	0.2307;      % phi_{EP}
     0.0172	0.0172;      % lambda_{fq}
     0.0111	0.0111;      % vartheta_E
     0.6837 0.6837;      % gamma_L
     4.6033 4.6033;     % k_L
     1   1;      % k_P
     3.4547	3.4547;      % phi_T
     0.3177	0.3177;      % lambda_{qf}
     0	0;      % psi_e
     0.6925	0.6925;      % phi_{PH}
     0.0111 0.0111;   % delta
     0   0;      % Migration input
     0.2421 0.2421;      % eta_L
     0.0018 0.0018;      % vartheta_P
     0.9809 0.9809;      % gamma_H 
     0.6533 0.6533;     % z 
     1.2672 1.2672;      % phi_{PL}
     0.7132 0.7132;      % eta_vartheta
     0   0;      % nons
     13.5293 13.5293;     % a_L
     2.5112 2.5112;     % b_L
     2.2433 2.2433;     % a_mu
     4.3125 4.3125;     % b_mu
     0.3478 0.3478;      % mu
     6.5860 6.5860;     % a_H
     13.2550 13.2550;     % b_H
     287.0751 287.0751;     % nu
     41  41      % m
     ];

RangeT = [Range1; Range2];

nfac = size(RangeT,1);
outs = [9,10,15];
% outs = repmat(bouts, 1, 2);

% for i = 1:2
%     for j = 1:3
%         outs((i - 1)*3 + j) = outs((i - 1)*3 + j) + ((i - 1)*20);
%     end
% end

RangeT = repmat(RangeT, N, 1);

RangeT(1,:) = [0 0];
RangeT(2,:) = [0 0];
RangeT(3,:) = [0 0];
%RangeT(1 + nfac,:) = [12439346 12439346];
% RangeT(1 + nfac*2,:) = [25409667 25409667];
% RangeT(1 + nfac*3,:) = [4662286 4662286];

%casos identificados, recuperados y fallecidos para cada grupo etario 
% Ninos
% RangeT(4+nfac*0,:)=[ydata(1+len*0,1) ydata(1+len*0,1)];
% RangeT(6+nfac*0,:)=[ydata(2+len*0,1) ydata(2+len*0,1)];
% RangeT(7+nfac*0,:)=[ydata(3+len*0,1) ydata(3+len*0,1)];
% 
% % Jovenes
% RangeT(4+nfac*1,:)=[ydata(1+len*1,1) ydata(1+len*1,1)];
% RangeT(6+nfac*1,:)=[ydata(2+len*1,1) ydata(2+len*1,1)];
% RangeT(7+nfac*1,:)=[ydata(3+len*1,1) ydata(3+len*1,1)];
% 
% % Adultos
% RangeT(4+nfac*2,:)=[ydata(1+len*2,1) ydata(1+len*2,1)];
% RangeT(6+nfac*2,:)=[ydata(2+len*2,1) ydata(2+len*2,1)];
% RangeT(7+nfac*2,:)=[ydata(3+len*2,1) ydata(3+len*2,1)];
% 
% % Mayores
% RangeT(4+nfac*3,:)=[ydata(1+len*3,1) ydata(1+len*3,1)];
% RangeT(6+nfac*3,:)=[ydata(2+len*3,1) ydata(2+len*3,1)];
% RangeT(7+nfac*3,:)=[ydata(3+len*3,1) ydata(3+len*3,1)];

domain=[0 250];
extra = struct();
extra.nmodels = N;
extra.action = 1;
extra.migration = mdistrib(0,3,3,251,0.8,5);

%Definir los nombres de variables y parametros





out_names_tot=[];
full_names_tot=[];



for i=1:N
full_names_tot = [full_names_tot append(Grupos(i),' ',VarNames) append(Grupos(i),' ',ParNames)];
% out_names_tot = [out_names_tot append(Grupos(i),' ',OutNames)];
end


full_names_tot = cellstr(full_names_tot(:))';
% out_names_tot = cellstr(out_names_tot(:))';

[T,~] = gsua_dataprep(model,RangeT,'domain',domain,'opt',extra,'out_names',...
    OutNames,'names',full_names_tot);

% T.Properties.CustomProperties.output = outs;
xdata = 0:251 - 1;
% xdata = 0:D-1;T.Properties.CustomProperties.output = [1:33];
TT=gsua_eval(T.Nominal,T,xdata);
% Solver = 'fmincon';
% Opt = optimoptions('fmincon','UseParallel',false,'MaxFunctionEvaluations',300, ...
%     'MaxIterations', 100, 'Display','off');

% N = 4;                    % Number of estimations
% Best = zeros(size(T,1),N);  % Matrix that saves factor's estimated values
% IpBest = Best;              % Matrix that saves optimization method initial point
% Residual = zeros(1,N);      % Vector that saves estimations cost function value
% ResBase = 12e-2;            % Pre-defined cost function value
% 
% ResTemp = 5e8;
% while ResTemp > ResBase
%     [T_est, ResTemp, IP] = gsua_pe(T,xdata,ydata,...
%         'solver',Solver,'N',1,'opt',Opt,'save',false);
% end

%Sort the estimated values according its cost function value
% [Residual, Idx] = sort(Residual);
% T.Est = Best(:, Idx);
% IpBest = IpBest(:,Idx);

% T.Est = T_est;
% 
% gsua_save(T)
% movefile("portable.mat", "Results/ColombiaResults/ColombiaEstimations.mat");
% save('Results/ColombiaResults/ColombiaEstimationsData.mat',...
%     'ydata','Residual','IpBest')

% figure
%gsua_eval(T.Nominal, T, 1:length(ydata), ydata);

% T_est = gsua_load(T);
% figure
% gsua_eval(T.Est,T_est,xdata,ydata);
