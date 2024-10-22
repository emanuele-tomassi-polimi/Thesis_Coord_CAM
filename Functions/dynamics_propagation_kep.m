function [time_prop, x_prop] = dynamics_propagation_kep(mu,  time_off,  x0, ode_options )

[time_prop, x_prop] = ode78(@(t, x) Dynamics_control_new(t, x,  mu),...
    time_off,  x0, ode_options);


    function[dx] = Dynamics_control_new(~, x, mu)

        rr = norm(x(1:3));


        r = x(1:3);
        dx = [ x(4:6);
            - mu/rr^3*r];


    end

end