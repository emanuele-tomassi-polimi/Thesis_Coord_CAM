function [c] = bisectionMethod_n(f, a, b, tol, iter_max)
 
    % Starting middle point definition, iter counter and initial function eval
    c=(a+b)/2;
    i = 1;
    [fun_a] = f(a);
    [fun_c] = f(c);
    fun_c_old = 0;

    % While loop for a modified bisection method with discrete functions
    while abs(fun_c) > tol && i < iter_max  &&  fun_c ~= fun_c_old
        i = i + 1;
        if sign(fun_c) == sign(fun_a)
            a=c;
            fun_a = fun_c;
        else
            b=c;
        end
        c=(a+b)/2;
        fun_c_old = fun_c;
        [fun_c] = f(c);
    end
end
