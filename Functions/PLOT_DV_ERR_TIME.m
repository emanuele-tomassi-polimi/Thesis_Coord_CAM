function [fig_dv_opt, fig_dv_analytic, fig_dv_comp,fig_dv_comp_all, fig_relerr_opt, fig_relerr_analytic, ...
    fig_3D2D_opt, fig_3D2D_opt_all, fig_3D2D_analytic, fig_3D2D_analytic_all, fig_CPUtime_opt, fig_CPUtime_analytic, fig_avgcputime, fig_merit_index] = ...
    PLOT_DV_ERR_TIME(INPUT, cases, case_index, vec, colors, colors_comp, flag_PoC, flag_opt, CAM_var, flag_TCAupdate)

d = CAM_var.d;

%% Plot all dv

set(0,'DefaultTextFontSize',24);
set(0,'DefaultAxesFontSize',24);
set(0,'DefaultLegendFontSize',24);

fig_dv_opt = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
tiledlayout(1,2);
line = zeros(1,7);
nexttile
for var = 1:length(cases)-3
    line(var) = plot(vec, INPUT.(cases{var}).('STM').DV_tot_opt,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-var*6,'DisplayName',cases{var});
    hold on
end
set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('$\Delta v \ [\frac{m}{s}]$')
grid on
box on

nexttile
for var = length(cases)-2:length(cases)
    line(var) = plot(vec, INPUT.(cases{var}).('STM').DV_tot_opt,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-(var-4)*6,'DisplayName',cases{var});
    hold on
end
% legend(cases{1}, cases{2}, cases{3}, cases{4}, cases{5}, cases{6}, cases{7}, 'Location','Best');
set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('$\Delta v \ [\frac{m}{s}]$')
grid on
box on

% Construct a Legend with the data from the sub-plots
hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
% Move the legend to the right side of the figure
hL.Layout.Tile = 'East';

%%

fig_dv_analytic = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
tiledlayout(1,2);
line = zeros(1,7);
nexttile
for var = 1:length(cases)-3
    line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').DV_tot_opt,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-var*6,'DisplayName',cases{var});
    hold on
end
set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('$\Delta v \ [\frac{m}{s}]$')
% legend(cases{1}, cases{2}, cases{3}, cases{4}, cases{5}, cases{6}, cases{7}, 'Location','Best');
grid on
box on

nexttile
for var = length(cases)-2:length(cases)
    line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').DV_tot_opt,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-(var-4)*6,'DisplayName',cases{var});
    hold on
end
% legend(cases{1}, cases{2}, cases{3}, cases{4}, cases{5}, cases{6}, cases{7}, 'Location','Best');
set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('$\Delta v \ [\frac{m}{s}]$')
grid on
box on

% Construct a Legend with the data from the sub-plots
hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
% Move the legend to the right side of the figure
hL.Layout.Tile = 'East';

%% Plot comparison between dv_tot, dv1, dv2 for one case
set(0,'DefaultTextFontSize',32);
set(0,'DefaultAxesFontSize',32);
set(0,'DefaultLegendFontSize',32);

fig_dv_comp = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.5]);

plot(vec, INPUT.(cases{case_index}).('STM').DV_tot_opt,'--.', 'Color', colors_comp(1), 'LineWidth',0.5, 'MarkerSize',80)
hold on
plot(vec, INPUT.(cases{case_index}).('STM').DV1_norm,'--^', 'Color', colors_comp(1), 'LineWidth',0.5, 'MarkerSize',15)
plot(vec, INPUT.(cases{case_index}).('STM').DV2_norm,'--', 'Marker',"square",'Color', colors_comp(1), 'LineWidth',0.5, 'MarkerSize',15)

plot(vec, INPUT.(cases{case_index}).('COOP_ANALYTICAL').DV_tot_opt,'--.', 'Color', colors_comp(2), 'LineWidth',0.5, 'MarkerSize',60)
plot(vec, INPUT.(cases{case_index}).('COOP_ANALYTICAL').DV1_norm,'--^', 'Color', colors_comp(2), 'LineWidth',0.5, 'MarkerSize',10)
plot(vec, INPUT.(cases{case_index}).('COOP_ANALYTICAL').DV2_norm,'--', 'Marker',"square",'Color', colors_comp(2), 'LineWidth',0.5, 'MarkerSize',10)

if flag_TCAupdate == 0
    plot(vec, INPUT.(cases{case_index}).('non_coop').DV_norm,'--.', 'Color', colors_comp(4), 'LineWidth',0.5, 'MarkerSize',40)
    legend('$\Delta v_{tot}$ - numerical', '$\Delta v_{p}$ - numerical', '$\Delta v_{s}$ - numerical', ...
       '$\Delta v_{tot}$ - analytical', '$\Delta v_{p}$ - analytical', '$\Delta v_{s}$ - analytical', ...
       '$\Delta v$ - non coop NLP','Location','Best');
else
    legend('$\Delta v_{tot}$ - numerical', '$\Delta v_{p}$ - numerical', '$\Delta v_{s}$ - numerical', ...
       '$\Delta v_{tot}$ - analytical', '$\Delta v_{p}$ - analytical', '$\Delta v_{s}$ - analytical','Location','Best');

end

set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('$\Delta v \ [\frac{m}{s}]$')
box on
grid on


set(0,'DefaultTextFontSize',24);
set(0,'DefaultAxesFontSize',24);
set(0,'DefaultLegendFontSize',24);

other_cases = cases;
other_cases(case_index) = [];

fig_dv_comp_all = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.6]);
for var = 1:length(other_cases)

    subplot(2,3,var)
    plot(vec, INPUT.(other_cases{var}).('STM').DV_tot_opt,'--.', 'Color', colors_comp(1), 'LineWidth',0.5, 'MarkerSize',50)
    hold on
    plot(vec, INPUT.(other_cases{var}).('STM').DV1_norm,'--^', 'Color', colors_comp(1), 'LineWidth',0.5, 'MarkerSize',15)
    plot(vec, INPUT.(other_cases{var}).('STM').DV2_norm,'--', 'Marker',"square",'Color', colors_comp(1), 'LineWidth',0.5, 'MarkerSize',15)
    
    plot(vec, INPUT.(other_cases{var}).('COOP_ANALYTICAL').DV_tot_opt,'--.', 'Color', colors_comp(2), 'LineWidth',0.5, 'MarkerSize',35)
    plot(vec, INPUT.(other_cases{var}).('COOP_ANALYTICAL').DV1_norm,'--^', 'Color', colors_comp(2), 'LineWidth',0.5, 'MarkerSize',10)
    plot(vec, INPUT.(other_cases{var}).('COOP_ANALYTICAL').DV2_norm,'--', 'Marker',"square",'Color', colors_comp(2), 'LineWidth',0.5, 'MarkerSize',10)
    
   
    if flag_TCAupdate == 0
        plot(vec, INPUT.(other_cases{var}).('non_coop').DV_norm,'--.', 'Color', colors_comp(4), 'LineWidth',0.5, 'MarkerSize',25)
        if var == length(other_cases)    
            legend('$\Delta v_{tot}$ - numerical', '$\Delta v_{p}$ - numerical', '$\Delta v_{s}$ - numerical', ...
               '$\Delta v_{tot}$ - analytical', '$\Delta v_{p}$ - analytical', '$\Delta v_{s}$ - analytical','$\Delta v$ - non coop NLP','Position',[0.61 0.45 0.1 0.1])
        end
    else
        if var == length(other_cases)
            legend('$\Delta v_{tot}$ - numerical', '$\Delta v_{p}$ - numerical', '$\Delta v_{s}$ - numerical', ...
               '$\Delta v_{tot}$ - analytical', '$\Delta v_{p}$ - analytical', '$\Delta v_{s}$ - analytical','Position',[0.61 0.45 0.1 0.1])
        end
    end

    set(gca,'yscale','log')
    xlabel('Number of orbits before TCA')
    ylabel('$\Delta v \ [\frac{m}{s}]$')
    box on
    grid on
    title(other_cases{var})
end




%% Plot error w.r.t. constraint
% set(0,'DefaultTextFontSize',20);
% set(0,'DefaultAxesFontSize',20);
% set(0,'DefaultLegendFontSize',20);
if flag_PoC == 0
    size_markers = [60 52 46 40 60 50 40];
else
    size_markers = [60 57 54 51 60 57 54];
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

%%

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


%% plot 3d or 2d representation

% set(0,'DefaultTextFontSize',20);
% set(0,'DefaultAxesFontSize',20);
% set(0,'DefaultLegendFontSize',20);

d_m = d * 1000;

if flag_PoC == 0

    fig_3D2D_opt = figure();
    BP_struct = INPUT.(cases{case_index}).BP_struct;
    SMD = INPUT.(cases{case_index}).SMD;
    scatter(0,0,100,'k', 'filled')
    hold on
    axis equal
    %scatter(BP_struct.be(2)*1000,BP_struct.be(1)*1000, 100,'k', 'filled');
    threshold_chan = smd2poc(BP_struct,SMD,3);
    u = BP_struct.u;
    v = @(zeta,ksi) ((ksi/(BP_struct.sigma_ksi*1000))^2 + (zeta/(BP_struct.sigma_zeta*1000))^2 - 2*BP_struct.rho*(ksi*zeta/((BP_struct.sigma_ksi*1000)*(BP_struct.sigma_zeta*1000)))) / (1 - BP_struct.rho^2);
    PoC =  @(zeta,ksi) exp(-v(zeta,ksi)/2) * ( (1-exp(-u/2)) + v(zeta,ksi)/2*(1-exp(-u/2)*(1+u/2)) +...
        + v(zeta,ksi)^2/8*(1-exp(-u/2)*(1+u/2 + u^2/8)) +...
        + v(zeta,ksi)^3/48*(1-exp(-u/2)*(1+u/2 + u^2/8 + u^3/48))  );
    fimplicit(@(zeta,ksi) PoC(zeta,ksi) - threshold_chan,  '-.k','LineWidth', 1, 'Display', 'off' );
    scatter(INPUT.(cases{case_index}).('STM').TCA_positions_proj(2,:), ...
        INPUT.(cases{case_index}).('STM').TCA_positions_proj(1,:),50,vec,'filled');
    
    txt = sprintf('$P_c$ = %.1e\n', threshold_chan);
    legend('Secondary @TCA',txt,'Location','best' );

    c = colorbar;
    colormap turbo
    c.Label.String = 'Number of orbits before TCA';
    c.Label.Interpreter='latex';
    xlabel('$\zeta$ [m]');
    ylabel('$\xi$ [m]');
    xlim([-110 110])
    ylim([-90 90])
    grid minor
    box on


    other_cases = cases;
    other_cases(case_index) = [];
    
    fig_3D2D_opt_all = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.6]);
    for var = 1:length(other_cases)
        subplot(2,3,var)
        BP_struct = INPUT.(cases{var}).BP_struct;
        SMD = INPUT.(cases{var}).SMD;
        scatter(0,0,100,'k', 'filled')
        hold on
        grid minor
        axis equal
        %scatter(BP_struct.be(2)*1000,BP_struct.be(1)*1000, 100,'k', 'filled');
        threshold_chan = smd2poc(BP_struct,SMD,3);
        u = BP_struct.u;
        v = @(zeta,ksi) ((ksi/(BP_struct.sigma_ksi*1000))^2 + (zeta/(BP_struct.sigma_zeta*1000))^2 - 2*BP_struct.rho*(ksi*zeta/((BP_struct.sigma_ksi*1000)*(BP_struct.sigma_zeta*1000)))) / (1 - BP_struct.rho^2);
        PoC =  @(zeta,ksi) exp(-v(zeta,ksi)/2) * ( (1-exp(-u/2)) + v(zeta,ksi)/2*(1-exp(-u/2)*(1+u/2)) +...
            + v(zeta,ksi)^2/8*(1-exp(-u/2)*(1+u/2 + u^2/8)) +...
            + v(zeta,ksi)^3/48*(1-exp(-u/2)*(1+u/2 + u^2/8 + u^3/48))  );
        fimplicit(@(zeta,ksi) PoC(zeta,ksi) - threshold_chan,  '-.k','LineWidth', 1, 'Display', 'off' );
        scatter(INPUT.(cases{var}).('STM').TCA_positions_proj(2,:), ...
            INPUT.(cases{var}).('STM').TCA_positions_proj(1,:),50,vec,'filled');
    
        c = colorbar;
        colormap turbo
        c.Label.String = 'Number of orbits before TCA';
        c.Label.Interpreter='latex';
        xlabel('$\zeta$ [m]');
        ylabel('$\xi$ [m]');
        box on
        if var == length(other_cases)
            legend('Secondary @TCA',txt,'Position',[0.61 0.45 0.1 0.1]);
        end
        title(other_cases{var})
    end



    fig_3D2D_analytic = figure();
    BP_struct = INPUT.(cases{case_index}).BP_struct;
    SMD = INPUT.(cases{case_index}).SMD;
    scatter(0,0,100,'k', 'filled')
    hold on
    axis equal
    %scatter(BP_struct.be(2)*1000,BP_struct.be(1)*1000, 100,'k', 'filled');
    threshold_chan = smd2poc(BP_struct,SMD,3);
    u = BP_struct.u;
    v = @(zeta,ksi) ((ksi/(BP_struct.sigma_ksi*1000))^2 + (zeta/(BP_struct.sigma_zeta*1000))^2 - 2*BP_struct.rho*(ksi*zeta/((BP_struct.sigma_ksi*1000)*(BP_struct.sigma_zeta*1000)))) / (1 - BP_struct.rho^2);
    PoC =  @(zeta,ksi) exp(-v(zeta,ksi)/2) * ( (1-exp(-u/2)) + v(zeta,ksi)/2*(1-exp(-u/2)*(1+u/2)) +...
        + v(zeta,ksi)^2/8*(1-exp(-u/2)*(1+u/2 + u^2/8)) +...
        + v(zeta,ksi)^3/48*(1-exp(-u/2)*(1+u/2 + u^2/8 + u^3/48))  );
    fimplicit(@(zeta,ksi) PoC(zeta,ksi) - threshold_chan,  '-.k','LineWidth', 1, 'Display', 'off' );
    scatter(INPUT.(cases{case_index}).('COOP_ANALYTICAL').TCA_positions_proj(2,:), ...
        INPUT.(cases{case_index}).('COOP_ANALYTICAL').TCA_positions_proj(1,:),50,vec,'filled');
    
    txt = sprintf('$P_c$ = %.1e\n', threshold_chan);
    legend('Secondary @TCA',txt,'Location','best' );

    c = colorbar;
    colormap turbo
    c.Label.String = 'Number of orbits before TCA';
    c.Label.Interpreter='latex';
    xlabel('$\zeta$ [m]');
    ylabel('$\xi$ [m]');
    grid minor
    box on
    xlim([-110 110])
    ylim([-90 90])
    
    fig_3D2D_analytic_all = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.6]);
    for var = 1:length(other_cases)
        subplot(2,3,var)
        BP_struct = INPUT.(cases{var}).BP_struct;
        SMD = INPUT.(cases{var}).SMD;
        scatter(0,0,100,'k', 'filled')
        hold on
        grid minor
        axis equal
        %scatter(BP_struct.be(2)*1000,BP_struct.be(1)*1000, 100,'k', 'filled');
        threshold_chan = smd2poc(BP_struct,SMD,3);
        u = BP_struct.u;
        v = @(zeta,ksi) ((ksi/(BP_struct.sigma_ksi*1000))^2 + (zeta/(BP_struct.sigma_zeta*1000))^2 - 2*BP_struct.rho*(ksi*zeta/((BP_struct.sigma_ksi*1000)*(BP_struct.sigma_zeta*1000)))) / (1 - BP_struct.rho^2);
        PoC =  @(zeta,ksi) exp(-v(zeta,ksi)/2) * ( (1-exp(-u/2)) + v(zeta,ksi)/2*(1-exp(-u/2)*(1+u/2)) +...
            + v(zeta,ksi)^2/8*(1-exp(-u/2)*(1+u/2 + u^2/8)) +...
            + v(zeta,ksi)^3/48*(1-exp(-u/2)*(1+u/2 + u^2/8 + u^3/48))  );
        fimplicit(@(zeta,ksi) PoC(zeta,ksi) - threshold_chan,  '-.k','LineWidth', 1, 'Display', 'off' );
        scatter(INPUT.(cases{var}).('COOP_ANALYTICAL').TCA_positions_proj(2,:), ...
            INPUT.(cases{var}).('COOP_ANALYTICAL').TCA_positions_proj(1,:),50,vec,'filled');
    
        c = colorbar;
        colormap turbo
        c.Label.String = 'Number of orbits before TCA';
        c.Label.Interpreter='latex';
        xlabel('$\zeta$ [m]');
        ylabel('$\xi$ [m]');
        box on
        if var == length(other_cases)
            legend('Secondary @TCA',txt,'Position',[0.61 0.45 0.1 0.1]);
        end
        title(other_cases{var})
    end


elseif flag_PoC == 1

    fig_3D2D_opt = figure();
    xx=(-d_m:0.001:d_m);
    yy1=sqrt(d_m^2-xx.^2);
    yy2=-sqrt(d_m^2-xx.^2);
    hold on
    plot(xx,yy1,'-.','color','black');
    plot(xx,yy2,'-.','color','black');
    scatter(0,0,120,[0 0 0],'filled');
    scatter(INPUT.(cases{case_index}).('STM').TCA_positions_proj(2,:), ...
        INPUT.(cases{case_index}).('STM').TCA_positions_proj(1,:),50,vec,'filled');
    c=colorbar;
    colormap turbo
    c.Label.String=('Number of orbits before TCA');
    c.Label.Interpreter='latex';
    ylabel('$\xi$ [m]');
    xlabel('$\zeta$[m]');
    txt = sprintf('B-plane miss distance:\n%.1f km', d);
    legend(txt,'', 'Secondary @TCA','','Location','best');
    grid minor
    axis equal
    xlim([-1.2*d_m 1.2*d_m]);
    ylim([-1.2*d_m 1.2*d_m]);
    box on

    other_cases = cases;
    other_cases(case_index) = [];
    
    fig_3D2D_opt_all = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.6]);
    for var = 1:length(other_cases)
        subplot(2,3,var)
        hold on
        plot(xx,yy1,'-.','color','black');
        plot(xx,yy2,'-.','color','black');
        scatter(0,0,120,[0 0 0],'filled');
        scatter(INPUT.(cases{var}).('STM').TCA_positions_proj(2,:), ...
            INPUT.(cases{var}).('STM').TCA_positions_proj(1,:),50,vec,'filled');
        c=colorbar;
        colormap turbo
        c.Label.String=('Number of orbits before TCA');
        c.Label.Interpreter='latex';
        ylabel('$\xi$ [m]');
        xlabel('$\zeta$[m]');
        grid minor
        axis equal
        xlim([-1.2*d_m 1.2*d_m]);
        ylim([-1.2*d_m 1.2*d_m]);
        box on
        if var == length(other_cases)
            legend(txt,'', 'Secondary @TCA','','Position',[0.61 0.45 0.1 0.1]);
        end
        title(other_cases{var})
    end


    fig_3D2D_analytic = figure();
    xx=(-d_m:0.001:d_m);
    yy1=sqrt(d_m^2-xx.^2);
    yy2=-sqrt(d_m^2-xx.^2);
    hold on
    plot(xx,yy1,'-.','color','black');
    plot(xx,yy2,'-.','color','black');
    scatter(0,0,120,[0 0 0],'filled');
    scatter(INPUT.(cases{case_index}).('COOP_ANALYTICAL').TCA_positions_proj(2,:), ...
        INPUT.(cases{case_index}).('COOP_ANALYTICAL').TCA_positions_proj(1,:),50,vec,'filled');
    c=colorbar;
    colormap turbo
    c.Label.String=('Number of orbits before TCA');
    c.Label.Interpreter='latex';
    ylabel('$\xi$ [m]');
    xlabel('$\zeta$[m]');
    txt = sprintf('B-plane miss distance:\n%.1f km', d);
    legend(txt,'', 'Secondary @TCA','','Location','best');
    grid minor
    axis equal
    xlim([-1.2*d_m 1.2*d_m]);
    ylim([-1.2*d_m 1.2*d_m]);
    box on
    
    fig_3D2D_analytic_all = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.6]);
    for var = 1:length(other_cases)
        subplot(2,3,var)
        hold on
        plot(xx,yy1,'-.','color','black');
        plot(xx,yy2,'-.','color','black');
        scatter(0,0,120,[0 0 0],'filled');
        scatter(INPUT.(cases{var}).('COOP_ANALYTICAL').TCA_positions_proj(2,:), ...
            INPUT.(cases{var}).('COOP_ANALYTICAL').TCA_positions_proj(1,:),50,vec,'filled');
        c=colorbar;
        colormap turbo
        c.Label.String=('Number of orbits before TCA');
        c.Label.Interpreter='latex';
        ylabel('$\xi$ [m]');
        xlabel('$\zeta$[m]');
        grid minor
        axis equal
        xlim([-1.2*d_m 1.2*d_m]);
        ylim([-1.2*d_m 1.2*d_m]);
        box on
        if var == length(other_cases)
            legend(txt,'', 'Secondary @TCA','','Position',[0.61 0.45 0.1 0.1]);
        end
        title(other_cases{var})
    end



elseif flag_PoC == 2

    fig_3D2D_opt = figure();
    [x_sphere, y_sphere, z_sphere] = sphere(64);
    h = surf(d_m*x_sphere, d_m*y_sphere, d_m*z_sphere);
    set(h, 'FaceAlpha', 0.5, 'FaceColor', [0.8 0.8 0.8], 'LineStyle', '-.', 'EdgeColor', [0.5 0.5 0.5], 'EdgeAlpha', 0.5)
    hold on
    scatter3(0,0,0,120,[0 0 0],'filled');
    scatter3( INPUT.(cases{case_index}).('STM').rel_pos(1,:), ...
        INPUT.(cases{case_index}).('STM').rel_pos(2,:), ...
        INPUT.(cases{case_index}).('STM').rel_pos(3,:),100,vec,'filled');
    c=colorbar;
    colormap turbo
    c.Label.String=('Number of orbits before TCA');
    c.Label.Interpreter='latex';
    clim([0 8])
    xlabel('$x$ [m]');
    ylabel('$y$ [m]');
    zlabel('$z$ [m]');
    grid minor
    axis equal
    box on
    txt = sprintf('3D miss distance:\n%.1f km', d);
    legend(txt, 'Secondary @TCA','', 'Location', 'best');

    other_cases = cases;
    other_cases(case_index) = [];
    
    fig_3D2D_opt_all = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.6]);
    for var = 1:length(other_cases)
        subplot(2,3,var)
        h = surf(d_m*x_sphere, d_m*y_sphere, d_m*z_sphere);
        set(h, 'FaceAlpha', 0.5, 'FaceColor', [0.8 0.8 0.8], 'LineStyle', '-.', 'EdgeColor', [0.5 0.5 0.5], 'EdgeAlpha', 0.5)
        hold on
        scatter3(0,0,0,120,[0 0 0],'filled');
        scatter3( INPUT.(cases{var}).('STM').rel_pos(1,:), ...
            INPUT.(cases{var}).('STM').rel_pos(2,:), ...
            INPUT.(cases{var}).('STM').rel_pos(3,:),100,vec,'filled');
        c=colorbar;
        colormap turbo
        c.Label.String=('Number of orbits before TCA');
        c.Label.Interpreter='latex';
        clim([0 8])
        xlabel('$x$ [m]');
        ylabel('$y$ [m]');
        zlabel('$z$ [m]');
        grid minor
        axis equal
        box on
        if var == length(other_cases)
            legend(txt, 'Secondary @TCA','','Position',[0.61 0.45 0.1 0.1]);
        end
        title(other_cases{var})
    end

    fig_3D2D_analytic = figure();
    [x_sphere, y_sphere, z_sphere] = sphere(64);
    h = surf(d_m*x_sphere, d_m*y_sphere, d_m*z_sphere);
    set(h, 'FaceAlpha', 0.5, 'FaceColor', [0.8 0.8 0.8], 'LineStyle', '-.', 'EdgeColor', [0.5 0.5 0.5], 'EdgeAlpha', 0.5)
    hold on
    scatter3(0,0,0,120,[0 0 0],'filled');
    scatter3( INPUT.(cases{case_index}).('COOP_ANALYTICAL').rel_pos(1,:), ...
        INPUT.(cases{case_index}).('COOP_ANALYTICAL').rel_pos(2,:), ...
        INPUT.(cases{case_index}).('COOP_ANALYTICAL').rel_pos(3,:),100,vec,'filled');
    c=colorbar;
    colormap turbo
    c.Label.String=('Number of orbits before TCA');
    c.Label.Interpreter='latex';
    clim([0 8])
    xlabel('$x$ [m]');
    ylabel('$y$ [m]');
    zlabel('$z$ [m]');
    grid minor
    axis equal
    box on
    txt = sprintf('3D miss distance:\n%.1f km', d);
    legend(txt, 'Secondary @TCA','', 'Location', 'best');

    fig_3D2D_analytic_all = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.6]);
    for var = 1:length(other_cases)
        subplot(2,3,var)
        h = surf(d_m*x_sphere, d_m*y_sphere, d_m*z_sphere);
        set(h, 'FaceAlpha', 0.5, 'FaceColor', [0.8 0.8 0.8], 'LineStyle', '-.', 'EdgeColor', [0.5 0.5 0.5], 'EdgeAlpha', 0.5)
        hold on
        scatter3(0,0,0,120,[0 0 0],'filled');
        scatter3( INPUT.(cases{var}).('COOP_ANALYTICAL').rel_pos(1,:), ...
            INPUT.(cases{var}).('COOP_ANALYTICAL').rel_pos(2,:), ...
            INPUT.(cases{var}).('COOP_ANALYTICAL').rel_pos(3,:),100,vec,'filled');
        c=colorbar;
        colormap turbo
        c.Label.String=('Number of orbits before TCA');
        c.Label.Interpreter='latex';
        clim([0 8])
        xlabel('$x$ [m]');
        ylabel('$y$ [m]');
        zlabel('$z$ [m]');
        grid minor
        axis equal
        box on
        if var == length(other_cases)
            legend(txt, 'Secondary @TCA','','Position',[0.61 0.45 0.1 0.1]);
        end
        title(other_cases{var})
    end

end



%% plot CPU time
% set(0,'DefaultTextFontSize',20);
% set(0,'DefaultAxesFontSize',20);
% set(0,'DefaultLegendFontSize',20);


fig_CPUtime_opt = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
tiledlayout(1,2);
line = zeros(1,7);
nexttile
for var = 1:length(cases)-3
    line(var) = plot(vec, INPUT.(cases{var}).('STM').t_CPU,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-var*3,'DisplayName',cases{var});
    hold on
end
set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('CPU Time $[s]$')
box on
grid on

nexttile
for var = length(cases)-2:length(cases)
    line(var) = plot(vec, INPUT.(cases{var}).('STM').t_CPU,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-(var-4)*3,'DisplayName',cases{var});
    hold on
end
set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('CPU Time $[s]$')
box on
grid on

% Construct a Legend with the data from the sub-plots
hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
% Move the legend to the right side of the figure
hL.Layout.Tile = 'East';



fig_CPUtime_analytic = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
tiledlayout(1,2);
line = zeros(1,7);
nexttile
for var = 1:length(cases)-3
    line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').t_CPU,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-var*3,'DisplayName',cases{var});
    hold on
end
set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('CPU Time $[s]$')
box on
grid on

nexttile
for var = length(cases)-2:length(cases)
    line(var) = plot(vec, INPUT.(cases{var}).('COOP_ANALYTICAL').t_CPU,'--.', 'Color', colors(var), 'LineWidth',0.5, 'MarkerSize',60-(var-4)*3,'DisplayName',cases{var});
    hold on
end
set(gca,'yscale','log')
xlabel('Number of orbits before TCA')
ylabel('CPU Time $[s]$')
box on
grid on

% Construct a Legend with the data from the sub-plots
hL = legend([line(1), line(2), line(3), line(4), line(5), line(6), line(7)]); 
% Move the legend to the right side of the figure
hL.Layout.Tile = 'East';



%% plot comparison bwtween avg cpu time and error

% set(0,'DefaultTextFontSize',20);
% set(0,'DefaultAxesFontSize',20);
% set(0,'DefaultLegendFontSize',20);

fig_avgcputime = [];

if flag_opt == 3
    % compute the 3 methods average CPU times for the optimization of each case
    avg_cpu_time_non_coop = zeros(1,length(cases));             std_noncoop = zeros(1,length(cases));
    avg_cpu_time_coop_analytical = zeros(1,length(cases));      std_coop_analytical = zeros(1,length(cases));
    avg_cpu_time_coop_prop = zeros(1,length(cases));            std_coop_prop = zeros(1,length(cases));
    avg_cpu_time_coop_STM = zeros(1,length(cases));             std_coop_STM = zeros(1,length(cases));
    min_cpu_time_non_coop = zeros(1,length(cases));
    min_cpu_time_coop_analytical = zeros(1,length(cases));
    min_cpu_time_coop_prop = zeros(1,length(cases));
    min_cpu_time_coop_STM = zeros(1,length(cases));
    max_cpu_time_non_coop = zeros(1,length(cases));
    max_cpu_time_coop_analytical = zeros(1,length(cases));
    max_cpu_time_coop_prop = zeros(1,length(cases));
    max_cpu_time_coop_STM = zeros(1,length(cases));

    for var = 1:length(cases)
        [std_noncoop(var),avg_cpu_time_non_coop(var)] = std(INPUT.(cases{var}).('non_coop').t_CPU);
        [std_coop_analytical(var),avg_cpu_time_coop_analytical(var)] = std(INPUT.(cases{var}).('COOP_ANALYTICAL').t_CPU);
        [std_coop_prop(var),avg_cpu_time_coop_prop(var)] = std(INPUT.(cases{var}).('PROP').t_CPU);
        [std_coop_STM(var),avg_cpu_time_coop_STM(var)] = std(INPUT.(cases{var}).('STM').t_CPU);
        min_cpu_time_non_coop(var) = min(INPUT.(cases{var}).('non_coop').t_CPU);
        min_cpu_time_coop_analytical(var) = min(INPUT.(cases{var}).('COOP_ANALYTICAL').t_CPU);
        min_cpu_time_coop_prop(var) = min(INPUT.(cases{var}).('PROP').t_CPU);
        min_cpu_time_coop_STM(var) = min(INPUT.(cases{var}).('STM').t_CPU);
        max_cpu_time_non_coop(var) = max(INPUT.(cases{var}).('non_coop').t_CPU);
        max_cpu_time_coop_analytical(var) = max(INPUT.(cases{var}).('COOP_ANALYTICAL').t_CPU);
        max_cpu_time_coop_prop(var) = max(INPUT.(cases{var}).('PROP').t_CPU);
        max_cpu_time_coop_STM(var) = max(INPUT.(cases{var}).('STM').t_CPU);
    end
    
    % plot the average computational time
    vec_temp = 1:1:length(cases);
    fig_avgcputime = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.55]);
    tiledlayout(1,2)
    nexttile
    errorbar(vec_temp, avg_cpu_time_coop_STM, avg_cpu_time_coop_STM-min_cpu_time_coop_STM,max_cpu_time_coop_STM-avg_cpu_time_coop_STM, '.', 'MarkerSize',55, 'LineWidth',4,'Color', colors_comp(1))
    hold on
    errorbar(vec_temp, avg_cpu_time_coop_analytical, avg_cpu_time_coop_analytical-min_cpu_time_coop_analytical, max_cpu_time_coop_analytical-avg_cpu_time_coop_analytical, '.', 'MarkerSize',50, 'LineWidth',3,'Color', colors_comp(2))
    errorbar(vec_temp, avg_cpu_time_coop_prop, avg_cpu_time_coop_prop-min_cpu_time_coop_prop, max_cpu_time_coop_prop-avg_cpu_time_coop_prop, '.', 'MarkerSize',45, 'LineWidth',2, 'Color', colors_comp(3))
    %errorbar(vec_temp, avg_cpu_time_non_coop, avg_cpu_time_non_coop-min_cpu_time_non_coop, max_cpu_time_non_coop-avg_cpu_time_non_coop, '.', 'MarkerSize',40, 'LineWidth',1)
    set(gca,'yscale','log')
    grid on
    set(gca,'xtick',vec_temp,'xticklabel',cases)
    xlim([0.5 length(cases)+0.5])
    xlabel('Case')
    ylabel('CPU Time [s]')
    legend('NUM-STM','AN-STM','NUM-PROP', 'location','eastoutside')

    
    avg_err_non_coop = zeros(1,length(cases));             std_err_noncoop = zeros(1,length(cases));
    avg_err_coop_analytical = zeros(1,length(cases));      std_err_coop_analytical = zeros(1,length(cases));
    avg_err_coop_prop = zeros(1,length(cases));            std_err_coop_prop = zeros(1,length(cases));
    avg_err_coop_STM = zeros(1,length(cases));             std_err_coop_STM = zeros(1,length(cases));
    min_err_non_coop = zeros(1,length(cases));
    min_err_coop_analytical = zeros(1,length(cases));
    min_err_coop_prop = zeros(1,length(cases));
    min_err_coop_STM = zeros(1,length(cases));
    max_err_non_coop = zeros(1,length(cases));
    max_err_coop_analytical = zeros(1,length(cases));
    max_err_coop_prop = zeros(1,length(cases));
    max_err_coop_STM = zeros(1,length(cases));

    if flag_PoC == 0
        for var = 1:length(cases)
            [std_err_noncoop(var),avg_err_non_coop(var)] = std(abs(INPUT.(cases{var}).('non_coop').Pc_real - 1e-6)/(1e-6)*100);
            [std_err_coop_analytical(var),avg_err_coop_analytical(var)] = std(abs(INPUT.(cases{var}).('COOP_ANALYTICAL').Pc_real - 1e-6)/(1e-6)*100);
            [std_err_coop_prop(var),avg_err_coop_prop(var)] = std(abs(INPUT.(cases{var}).('PROP').Pc_real - 1e-6)/(1e-6)*100);
            [std_err_coop_STM(var),avg_err_coop_STM(var)] = std(abs(INPUT.(cases{var}).('STM').Pc_real - 1e-6)/(1e-6)*100);
            min_err_non_coop(var) = min(abs(INPUT.(cases{var}).('non_coop').Pc_real - 1e-6)/(1e-6)*100);
            min_err_coop_analytical(var) = min(abs(INPUT.(cases{var}).('COOP_ANALYTICAL').Pc_real - 1e-6)/(1e-6)*100);
            min_err_coop_prop(var) = min(abs(INPUT.(cases{var}).('PROP').Pc_real - 1e-6)/(1e-6)*100);
            min_err_coop_STM(var) = min(abs(INPUT.(cases{var}).('STM').Pc_real - 1e-6)/(1e-6)*100);
            max_err_non_coop(var) = max(abs(INPUT.(cases{var}).('non_coop').Pc_real - 1e-6)/(1e-6)*100);
            max_err_coop_analytical(var) = max(abs(INPUT.(cases{var}).('COOP_ANALYTICAL').Pc_real - 1e-6)/(1e-6)*100);
            max_err_coop_prop(var) = max(abs(INPUT.(cases{var}).('PROP').Pc_real - 1e-6)/(1e-6)*100);
            max_err_coop_STM(var) = max(abs(INPUT.(cases{var}).('STM').Pc_real - 1e-6)/(1e-6)*100);
        end
    else
        for var = 1:length(cases)
            [std_err_noncoop(var),avg_err_non_coop(var)] = std(INPUT.(cases{var}).('non_coop').error_TCA);
            [std_err_coop_analytical(var),avg_err_coop_analytical(var)] = std(INPUT.(cases{var}).('COOP_ANALYTICAL').error_TCA);
            [std_err_coop_prop(var),avg_err_coop_prop(var)] = std(INPUT.(cases{var}).('PROP').error_TCA);
            [std_err_coop_STM(var),avg_err_coop_STM(var)] = std(INPUT.(cases{var}).('STM').error_TCA);
            min_err_non_coop(var) = min(INPUT.(cases{var}).('non_coop').error_TCA);
            min_err_coop_analytical(var) = min(INPUT.(cases{var}).('COOP_ANALYTICAL').error_TCA);
            min_err_coop_prop(var) = min(INPUT.(cases{var}).('PROP').error_TCA);
            min_err_coop_STM(var) = min(INPUT.(cases{var}).('STM').error_TCA);
            max_err_non_coop(var) = max(INPUT.(cases{var}).('non_coop').error_TCA);
            max_err_coop_analytical(var) = max(INPUT.(cases{var}).('COOP_ANALYTICAL').error_TCA);
            max_err_coop_prop(var) = max(INPUT.(cases{var}).('PROP').error_TCA);
            max_err_coop_STM(var) = max(INPUT.(cases{var}).('STM').error_TCA);
        end
    end

    nexttile
    errorbar(vec_temp, avg_err_coop_STM, avg_err_coop_STM-min_err_coop_STM,max_err_coop_STM-avg_err_coop_STM, '.', 'MarkerSize',55, 'LineWidth',4,'Color', colors_comp(1))
    hold on
    errorbar(vec_temp, avg_err_coop_analytical, avg_err_coop_analytical-min_err_coop_analytical, max_err_coop_analytical-avg_err_coop_analytical, '.', 'MarkerSize',50, 'LineWidth',3,'Color', colors_comp(2))
    errorbar(vec_temp, avg_err_coop_prop, avg_err_coop_prop-min_err_coop_prop, max_err_coop_prop-avg_err_coop_prop, '.', 'MarkerSize',45, 'LineWidth',2,'Color', colors_comp(3))
    % errorbar(vec_temp, avg_err_non_coop, avg_err_non_coop-min_err_non_coop, max_err_non_coop-avg_err_non_coop, '.', 'MarkerSize',40, 'LineWidth',1)
    set(gca,'yscale','log')
    grid on
    set(gca,'xtick',vec_temp,'xticklabel',cases)
    xlim([0.5 length(cases)+0.5])
    xlabel('Case')
    if flag_PoC == 0
        ylabel('PoC error [\%]')
    else
        ylabel('Constraint error [m]')
    end


    check_par_non_coop = avg_cpu_time_non_coop.*avg_err_non_coop;
    check_par_coop_analytical = avg_cpu_time_coop_analytical.*avg_err_coop_analytical;
    check_par_coop_STM = avg_cpu_time_coop_STM.*avg_err_coop_STM;
    check_par_coop_prop = avg_cpu_time_coop_prop.*avg_err_coop_prop;


    set(0,'DefaultTextFontSize',32);
    set(0,'DefaultAxesFontSize',32);
    set(0,'DefaultLegendFontSize',32);
    fig_merit_index = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.5]);
    scatter(vec_temp, check_par_coop_analytical, 230,'filled')
    hold on
    scatter(vec_temp, check_par_coop_STM, 230,'filled')
    scatter(vec_temp, check_par_coop_prop, 230,'filled')
    %scatter(vec_temp, check_par_non_coop, 230,'filled')
    legend('Analytical NLP','STM opt','Fully numerical opt', 'location','eastoutside')
    set(gca,'xtick',vec_temp,'xticklabel',cases)
    xlim([0.5 length(cases)+0.5])
    xlabel('Case')
    if flag_PoC == 0
        ylabel('$t_{CPU,avg} \cdot$ PoC$_{avg}$')
    else
        ylabel('$t_{CPU,avg} \cdot err_{avg}$')
    end
    set(gca,'yscale','log')
    grid on
    box on
    
end




