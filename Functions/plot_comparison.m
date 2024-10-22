
if flag_TCAupdate == 0
    INPUT = OUTPUT;
else
    INPUT = OUTPUT_realTCA;
end

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



%%% plot merit index figure with all 3 constraint
set(0,'DefaultTextFontSize',24);
set(0,'DefaultAxesFontSize',24);
set(0,'DefaultLegendFontSize',24);


vec_temp = [3 2 1];
marker_vec = ["o","+", "*", "square", "^", "pentagram", "v"];

if flag_PoC == 2
    fig_merit = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.4]);
end

hold off
subplot(1,3,vec_temp(flag_PoC+1))
for var = 1:length(cases)
    plot(avg_err_coop_STM(var),avg_cpu_time_coop_STM(var), 'LineWidth',2, 'MarkerSize',20,'Color',colors_comp(1), 'Marker',marker_vec(var))
    hold on
    plot(avg_err_coop_analytical(var),avg_cpu_time_coop_analytical(var),  'LineWidth',2, 'MarkerSize',20,'Color',colors_comp(2), 'Marker',marker_vec(var))
    plot(avg_err_coop_prop(var), avg_cpu_time_coop_prop(var), 'LineWidth',2, 'MarkerSize',20,'Color',colors_comp(3), 'Marker',marker_vec(var))
end
hold off
set(gca,'xscale','log')
set(gca,'yscale','log')

if flag_PoC == 0
    xlabel('PoC error [\%]')
else
    xlabel('Constraint error [m]')
end
ylabel('CPU Time [s]')

grid on
box on


if flag_PoC == 0
    title('Target: Probability of Collision')
elseif flag_PoC == 1
    title('Target: B-Plane Miss Distance')
else
    title('Target: 3D Miss Distance')
end


%% generate the legends
vec_x = [1 2];
vec_y = [1 1];

fig_leg = figure('Units', 'normalized', 'Position', [0, 0, 0.99, 0.9]);
subplot(2,1,1)
plot(vec_x, vec_y, '-','LineWidth',4, 'Color',colors_comp(1))
hold on
plot(vec_x, vec_y, '-','LineWidth',4, 'Color',colors_comp(2))
plot(vec_x, vec_y, '-','LineWidth',4, 'Color',colors_comp(3))

ylim([0 100]);
legend('NUM-STM','AN-STM','NUM-PROP','Orientation','horizontal')

subplot(2,1,2)

for var = 1:length(cases)
    plot(vec_x,vec_y, '.k','LineWidth',2, 'MarkerSize',20,'Marker',marker_vec(var));
    hold on
end

legend(cases{1},cases{2}, cases{3}, cases{4}, cases{5}, cases{6}, cases{7}, 'Orientation','horizontal'); 


%%
colors_temp = ["#da073b", "#073bda", "#3bda07","#EDB120"];
for var1 = 1:2
    if var1 == 1
        INPUT = OUTPUT;
    else
        INPUT = OUTPUT_realTCA;
    end

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

    set(0,'DefaultTextFontSize',24);
    set(0,'DefaultAxesFontSize',24);
    set(0,'DefaultLegendFontSize',24);

    if var1 == 1
        fig_comp = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.4]);
    end

    vec_temp = 1:1:length(cases);
    subplot(1,2,1)
    plot(vec_temp, avg_err_coop_STM, '.', 'MarkerSize',55, 'LineWidth',4,'Color', colors_temp(var1))
    hold on
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
    title('NUM-STM approach')
    legend('Nominal TCA', 'Real TCA', 'Location','best')


    subplot(1,2,2)
    plot(vec_temp, avg_err_coop_analytical, '.', 'MarkerSize',55, 'LineWidth',4,'Color', colors_temp(var1))
    hold on
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
    title('AN-STM approach')
    legend('Nominal TCA', 'Real TCA', 'Location','best')
    
end

%legend('Nominal TCA', 'Real TCA', 'Location','westoutside')
