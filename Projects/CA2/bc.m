function [pl, ql, pr, qr] = bc(xl, ul, xr, ur, t)
    pl = ul;
    ql = 0;
    pr = ur - 50;
    qr = 0;
end
