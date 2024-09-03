function heat_equation_solution
    m = 0;

    x = linspace(0, 1, 201); 
    t = linspace(0, 10, 201); 

    sol = pdepe(m, @Equation, @Init, @bc, x, t);

    u0 = sol(1,:, :); 
    u5 = sol(101,:, :); 
    u10 = sol(end,:, :);

    figure;
    plot(x, u0, 'b', x, u5, 'r', x, u10, 'g');
    legend('t=0', 't=5', 't=10');
    xlabel('x');
    ylabel('u(x,t)');
    title('Temperature Distribution in the Rod');

    figure;
    surf(x, t, sol);
    xlabel('Position x');
    ylabel('Time t');
    zlabel('Temperature u(x,t)');
    title('Temperature Distribution Over Time');

    figure;
    imagesc(x, t, sol);
    set(gca, 'YDir', 'normal');
    colormap(jet);
    colorbar;
    xlabel('Position x');
    ylabel('Time t');
    title('Temperature Distribution Over Space and Time');
end

function [c, f, s] = Equation(x, t, u, dudx)
    c = 50; 
    f = dudx; 
    s = 0;
end

function u0 = Init(x)
    u0 = 2 * exp(x); 
end

function [pl, ql, pr, qr] = bc(xl, ul, xr, ur, t)
    pl = ul; 
    ql = 0;
    pr = ur - 35;
    qr = 0;
end


