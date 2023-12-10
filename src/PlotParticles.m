function [plotS] = PlotParticles(stateS,compS,plotS)

if ~isfield(plotS, 'particlesfig')
    plotS.particlesfig = figure(1);
end

%% Extraction

rn = stateS.rn;
vn = stateS.vn;
an = stateS.an;
mn = stateS.mn;

simtime = compS.simtime;
maxsimtime = compS.maxsimtime;

% Plot parameters
boxviewsize = plotS.boxviewsize;
viewangle = plotS.viewangle;

%Frame setup
framecount = plotS.framecount;
doframesaving = plotS.doframesaving;
outputsmovieframespath = plotS.outputsmovieframespath;
frameext = plotS.frameext;

%% Plotting

figure(1)

clf;
grid on, hold on
ax1 = gca;

timestring = append('t: ',string(simtime),'/ ',string(maxsimtime));
text(0.5,0.8,timestring,'Units','normalized')

for p = 1:size(rn,1)
    
    relativemass = mn(p) / max(mn);
    particlecolor = [1 0 1-relativemass];
    maxparticlesize = 50;
    particlesize = max(relativemass*maxparticlesize,10);
    
    % Position

    plot3(ax1, rn(p,1), rn(p,2), rn(p,3), ...
        '.','Color',particlecolor,'MarkerSize', particlesize, 'LineWidth', 1)
    
    % Velocity
    
    velplot = boxviewsize / 10;
    velarrow = velplot * vn(p,:) / norm(vn(p,:));

    quiver3(rn(p,1),rn(p,2),rn(p,3),velarrow(1),velarrow(2),velarrow(3), ...
        'Color','magenta','LineWidth',1, ...
        'ShowArrowHead','on','MaxHeadSize',1e-1); % Burgers vectors

    % Acceleration
    
    accplot = boxviewsize / 10;
    accarrow = accplot * an(p,:) / norm(an(p,:));

    quiver3(rn(p,1),rn(p,2),rn(p,3),accarrow(1),accarrow(2),accarrow(3), ...
        'Color','green','LineWidth',1, ...
        'ShowArrowHead','on','MaxHeadSize',1e-1); % Burgers vectors
end

xlabel('x','FontSize',12); % Subplot label axes
ylabel('y','FontSize',12);
zlabel('z','FontSize',12);
ax1.XAxis.Exponent = 0; ax1.YAxis.Exponent = 0; ax1.ZAxis.Exponent = 0;

title('Mass positions');

xlim([-boxviewsize boxviewsize]);
ylim([-boxviewsize boxviewsize]);
zlim([-boxviewsize boxviewsize]);

view(viewangle);

%drawnow

if doframesaving == 1

    framecount = framecount + 1;

    % Save frames as figs:
    savefilefig = append(outputsmovieframespath, ...
                      'frame', num2str(framecount,'%d'), '.fig');
    saveas(plotS.particlesfig,savefilefig);
    % Save frames as images:
    savefile = append(outputsmovieframespath, ...
                      'frame', num2str(framecount,'%d'), frameext);
    saveas(plotS.particlesfig,savefile);

end

%% Update Bcoeff

plotS.framecount = framecount;

end