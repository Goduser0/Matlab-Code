A=[1 5 25 5^3
   1 10 100 10^3
   1 15 225 15^3
   1 20 400 20^3
   1 25 625 25^3
   1 30 900 30^3
   1 35 35*35 35^3
   1 40 40*40 40^3
   1 45 45*45 45^3
   1 50 50*50 50^3
   1 55 55*55 55^3
   ];
Y=[1.27 2.16 2.86 3.44 3.87 4.15 4.37 4.51 4.58 4.62 4.64]';

left=A'*A;
right=A'*Y;
a=inv(left)*right
e=Y'*(Y-A*a)