function [fig_tcatime_comp, fig_tcatime_comp_all, fig_dis_tcnom_tcreal_opt, fig_dis_tcnom_tcreal_analytical, fig_it_NLP_TCAupd, ...
    fig_relerr_opt, fig_relerr_analytic] = PLOT_REALT(INPUT, cases, case_index, vec, colors, colors_comp, flag_TCAupdate, flag_PoC)

%% Plot tca time

% set(0,'DefaultTextFontSize',20);
% set(0,'DefaultAxesFontSize',20);
% set(0,'DefaultLegendFontSize',20);
% 
% fig_TCAtime_opt = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
% tiledlayout(1,2);
% line = zeros(1,7);
% nexttile
% for var = 1:length(cases)-3
%     line(var) = plot(vec, INPUT.(cases{var}).('STM').tc_new,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-var*3,'DisplayName',cases{var});
%     hold on
% end
% xlabel('Number of orbits before TCA')
% ylabel('Time $[s]$')
% box on
% grid on
% 
% nexttile
% for var = length(cases)-2:length(cases)
%     line(var) = plot(vec, INPUT.(cases{var}).('STM').tc_new,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-(var-4)*3,'DisplayName',cases{var});
%     hold on
% end
% xlabel('Number of orbits before TCA')
% ylabel('Time $[s]$')
% box on
% grid on
% 
% % Construct a Legend with the data from the sub-plots
% hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
% % Move the legend to the right side of the figure
% hL.Layout.Tile = 'East';
% 
% fig_TCAtime_analytic = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
% tiledlayout(1,2);
% line = zeros(1,7);
% nexttile
% for var = 1:length(cases)-3
%     line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').tc_new,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-var*3,'DisplayName',cases{var});
%     hold on
% end
% xlabel('Number of orbits before TCA')
% ylabel('Time $[s]$')
% box on
% grid on
% 
% nexttile
% for var = length(cases)-2:length(cases)
%     line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').tc_new,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-(var-4)*3,'DisplayName',cases{var});
%     hold on
% end
% xlabel('Number of orbits before TCA')
% ylabel('Time $[s]$')
% box on
% grid on
% 
% % Construct a Legend with the data from the sub-plots
% hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
% % Move the legend to the right side of the figure
% hL.Layout.Tile = 'East';


set(0,'DefaultTextFontSize',32);
set(0,'DefaultAxesFontSize',32);
set(0,'DefaultLegendFontSize',32);

fig_tcatime_comp = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.5]);

plot(vec, INPUT.(cases{case_index}).('STM').tc_new,'--.', 'Color', colors_comp(1), 'LineWidth',0.5, 'MarkerSize',60)
hold on
plot(vec, INPUT.(cases{case_index}).('COOP_ANALYTICAL').tc_new,'--.', 'Color', colors_comp(2), 'LineWidth',0.5, 'MarkerSize',40)

xlabel('Number of orbits before TCA')
ylabel('TCA$_{real}$ $-$ TCA$_{nom}$ $[s]$')
legend('NUM-STM', 'AN-STM', 'Location','Best');
box on
grid minor


set(0,'DefaultTextFontSize',24);
set(0,'DefaultAxesFontSize',24);
set(0,'DefaultLegendFontSize',24);

other_cases = cases;
other_cases(case_index) = [];

fig_tcatime_comp_all = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.6]);
for var = 1:length(other_cases)

    subplot(2,3,var)
    plot(vec, INPUT.(other_cases{var}).('STM').tc_new,'--.', 'Color', colors_comp(1), 'LineWidth',0.5, 'MarkerSize',50)
    hold on    
    plot(vec, INPUT.(other_cases{var}).('COOP_ANALYTICAL').tc_new,'--.', 'Color', colors_comp(2), 'LineWidth',0.5, 'MarkerSize',35)
    
    if var == length(other_cases)
        legend('NUM-STM', 'AN-STM', 'Location','Best','Position',[0.61 0.45 0.1 0.1])
    end
    
    xlabel('Number of orbits before TCA')
    ylabel('TCA$_{real}$ $-$ TCA$_{nom}$ $[s]$')
    box on
    grid minor
    title(other_cases{var})
end

%% Plot difference between distace at tca nom and tca real
fig_dis_tcnom_tcreal_opt = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.33]);
tiledlayout(1,2);
line = zeros(1,7);
nexttile
for var = 1:length(cases)-3
    line(var) = plot(vec, INPUT.(cases{var}).('STM').distance_TCAnom - INPUT.(cases{var}).('STM').distance_TCAreal, '--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-var*3,'DisplayName',cases{var});
    hold on
end
%set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('$\Delta r_{TCA,nom} - \Delta r_{TCA,real} \ [m]$')
box on
grid minor

nexttile
for var = length(cases)-2:length(cases)
    line(var) = plot(vec, INPUT.(cases{var}).('STM').distance_TCAnom - INPUT.(cases{var}).('STM').distance_TCAreal, '--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-(var-4)*3,'DisplayName',cases{var});
    hold on
end
%set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('$\Delta r_{TCA,nom} - \Delta r_{TCA,real} \ [m]$')
box on
grid minor

% Construct a Legend with the data from the sub-plots
hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
% Move the legend to the right side of the figure
hL.Layout.Tile = 'East';

fig_dis_tcnom_tcreal_analytical = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.33]);
tiledlayout(1,2);
line = zeros(1,7);
nexttile
for var = 1:length(cases)-3
    line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').distance_TCAnom - INPUT.(cases{var}).('COOP_ANALYTICAL').distance_TCAreal, '--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-var*3,'DisplayName',cases{var});
    hold on
end
%set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('$\Delta r_{TCA,nom} - \Delta r_{TCA,real} \ [m]$')
box on
grid minor

nexttile
for var = length(cases)-2:length(cases)
    line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').distance_TCAnom - INPUT.(cases{var}).('COOP_ANALYTICAL').distance_TCAreal, '--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-(var-4)*3,'DisplayName',cases{var});
    hold on
end
%set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('$\Delta r_{TCA,nom} - \Delta r_{TCA,real} \ [m]$')
box on
grid minor

% Construct a Legend with the data from the sub-plots
hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
% Move the legend to the right side of the figure
hL.Layout.Tile = 'East';


%% Plot number of iterations or constraint at real tca
% set(0,'DefaultTextFontSize',20);
% set(0,'DefaultAxesFontSize',20);
% set(0,'DefaultLegendFontSize',20);

fig_it_NLP_TCAupd = [];
fig_relerr_opt = [];
fig_relerr_analytic = [];


if flag_TCAupdate == 1
    size_markers = [60 50 55 40 60 55 45];
    fig_it_NLP_TCAupd = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
    tiledlayout(1,2);
    line = zeros(1,7);
    nexttile
    for var = 1:length(cases)-3
        line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').iterations,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
        hold on
    end
    set(gca,'yscale','log')
    xlabel('Number of orbits before TCA')
    ylabel('$n^{\circ}$ of iterations')
    grid minor
    box on

    nexttile
    for var = length(cases)-2:length(cases)
        line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').iterations,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
        hold on
    end
    set(gca,'yscale','log')
    xlabel('Number of orbits before TCA')
    ylabel('$n^{\circ}$ of iterations')
    grid minor
    box on

    % Construct a Legend with the data from the sub-plots
    hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
    % Move the legend to the right side of the figure
    hL.Layout.Tile = 'East';
else
    if flag_PoC == 0
        size_markers = [60 50 55 40 60 50 55];
    elseif flag_PoC == 1 
        size_markers = [60 57 54 51 60 57 54];
    else
        size_markers = [60 50 40 55 60 55 50];
    end
    fig_relerr_opt = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
    tiledlayout(1,2);
    line = zeros(1,7);
    nexttile
    for var = 1:length(cases)-3
        if flag_PoC == 0
            line(var) = plot(vec, INPUT.(cases{var}).('STM').Pc_real,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
            if var == length(cases)-3
                plot([0 8], [1e-6 1e-6],"k-.",  'LineWidth', 3)
            end
        else
            line(var) = plot(vec, INPUT.(cases{var}).('STM').error_TCA,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
        end
        hold on
    end
    set(gca,'yscale','log')
    xlabel('Number of orbits before TCA')
    if flag_PoC == 0
        ylabel('PoC')
    else
        ylabel('Constraint error [m]')
    end
    box on
    grid on
    
    nexttile
    for var = length(cases)-2:length(cases)
        if flag_PoC == 0
            line(var) = plot(vec, INPUT.(cases{var}).('STM').Pc_real,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
            if var == length(cases)
                plot([0 8], [1e-6 1e-6],"k-.",  'LineWidth', 3)
            end
        else
            line(var) = plot(vec, INPUT.(cases{var}).('STM').error_TCA,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
        end
        
        hold on
    end
    set(gca,'yscale','log')
    xlabel('Number of orbits before TCA')
    if flag_PoC == 0
        ylabel('PoC')
    else
        ylabel('Constraint error [m]')
    end
    box on
    grid on
    
    % Construct a Legend with the data from the sub-plots
    hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
    % Move the legend to the right side of the figure
    hL.Layout.Tile = 'East';
    
    
    
    fig_relerr_analytic = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
    tiledlayout(1,2);
    line = zeros(1,7);
    nexttile
    for var = 1:length(cases)-3
        if flag_PoC == 0
            line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').Pc_real,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
            if var == length(cases)-3
                plot([0 8], [1e-6 1e-6],"k-.",  'LineWidth', 3)
            end
        else
            line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').error_TCA,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
        end
        hold on
    end
    set(gca,'yscale','log')
    xlabel('Number of orbits before TCA')
    if flag_PoC == 0
        ylabel('PoC')
    else
        ylabel('Constraint error [m]')
    end
    box on
    grid on
    
    nexttile
    for var = length(cases)-2:length(cases)
        if flag_PoC == 0
            line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').Pc_real,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
            if var == length(cases)
                plot([0 8], [1e-6 1e-6],"k-.",  'LineWidth', 3)
            end
        else
            line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').error_TCA,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',size_markers(var),'DisplayName',cases{var});
        end
        hold on
    end
    set(gca,'yscale','log')
    xlabel('Number of orbits before TCA')
    if flag_PoC == 0
        ylabel('PoC')
    else
        ylabel('Constraint error [m]')
    end
    box on
    grid on
    
    % Construct a Legend with the data from the sub-plots
    hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
    % Move the legend to the right side of the figure
    hL.Layout.Tile = 'East';
end


end