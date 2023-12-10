function [plotS] = PlotEnergy(stateS,compS,plotS)

if ~isfield(plotS, 'energyfig')
    plotS.energyfig = figure(2);
end

%% Extraction

H = stateS.H;
KE = stateS.KE;
PE = stateS.PE;
t = stateS.t;

curstep = compS.curstep;

%%

if curstep == 1
    return
end

figure(2)

clf;
grid on, hold on
ax2 = gca;

tplot = t(1:curstep);
Hplot = H(1:curstep);
KEplot = KE(1:curstep);
PEplot = PE(1:curstep);
 
% plot(ax2, t(1:curstep), H(1:curstep), ...
%     '--','LineWidth',5,'Color','black')
% plot(ax2, t(1:curstep), KE(1:curstep), ...
%     '-.','LineWidth',2,'Color','red')
% plot(ax2, t(1:curstep), PE(1:curstep), ...
%     ':','LineWidth',2,'Color','blue')
scatter(ax2, tplot(tplot(2:end) > 0), Hplot(tplot(2:end) > 0), ...
    36,'black','o','LineWidth',5)
scatter(ax2, tplot(tplot(2:end) > 0), KEplot(tplot(2:end) > 0), ...
    36,'red','o','LineWidth',2)
scatter(ax2, tplot(tplot(2:end) > 0), PEplot(tplot(2:end) > 0), ...
    36,'blue','o','LineWidth',2)

xlabel('Time','FontSize',12); % Subplot label axes
ylabel('Energy','FontSize',12);
ax2.XAxis.Exponent = 0; ax2.YAxis.Exponent = 0;

title('Energy vs time');

xlim([t(1) t(curstep)]);

%drawnow;

end