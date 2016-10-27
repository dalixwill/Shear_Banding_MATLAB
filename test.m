x = zeros(5,3,3);
x(1,1,1) = 2;
x(1,3,1) = 1;
x(2,1,3) = 5;
x(2,2,3) = 9;
disp(x)

vel_mag = sum(x.*x,2).^(0.5)
sum(x,