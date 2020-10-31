function [x,y,z,xp,yp,zp] = TGFSolve(A,ts,tgf)
% Finds TGF location from payload positions and times
% INPUTS:
%   A - A 4x3 array of payload positions in cartesian coordinates
%   ts - A 1x4 array of the times of detection for each payload
% OUTPUTS:
%   x,y,z - TGF location is cartesian coordinates

%Suppress warnings
warning('off') 

%Sort times
i=1;
while i <= length(ts)
    [T(i),I]=min(ts);
    ts(I)=inf;
    M(i)=I;
    i=i+1;
end

%Set payloads positions
x2=A(M(2),1)-A(M(1),1);
y2=A(M(2),2)-A(M(1),2);
z2=A(M(2),3)-A(M(1),3);
x3=A(M(3),1)-A(M(1),1);
y3=A(M(3),2)-A(M(1),2);
z3=A(M(3),3)-A(M(1),3);
x4=A(M(4),1)-A(M(1),1);
y4=A(M(4),2)-A(M(1),2);
z4=A(M(4),3)-A(M(1),3);

%Speed of light
c = 299792.458; 

syms x0
syms y0
syms z0

t2_1 = T(2)-T(1);
t3_1 = T(3)-T(1);
t4_1 = T(4)-T(1);
t3_2 = T(3)-T(2);
t4_2 = T(4)-T(2);
t4_3 = T(4)-T(3);

l = 10^-6;

equ2_1 = sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) == c*t2_1;
equ3_1 = sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) == c*t3_1;
equ4_1 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) == c*t4_1;
equ3_2_1 = sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2)-sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2) - c*t3_2 < l;
equ3_2_2 = sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2)-sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2) - c*t3_2 > -l;
equ4_2_1 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2) - c*t4_2 < l;
equ4_2_2 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2) - c*t4_2 > -l;
equ4_3_1 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2) - c*t4_3 < l;
equ4_3_2 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2) - c*t4_3 > -l;




try
    solution = solve(equ2_1,equ3_1,equ4_1,equ3_2_1,equ3_2_2,equ4_2_1,equ4_2_2,equ4_3_1,equ4_3_2,x0,y0,z0);
    g = real(double(solution.x0(1)));
catch
    solution = solve(equ2_1,equ3_1,equ4_1,x0,y0,z0);
end
%try
%    solution = vpasolve([equ2_1;equ3_1;equ4_1],[x0,y0,z0]);
%    g = double(solution.x0(1));
%catch
%    solution = solve(equ2_1,equ3_1,equ4_1,equ3_2_1,equ3_2_2,equ4_2_1,equ4_2_2,equ4_3_1,equ4_3_2,x0,y0,z0);
%end
real(double(solution.x0));
real(double(solution.y0));
real(double(solution.z0));


x01 = real(double(solution.x0(1)))+A(M(1),1);
y01 = real(double(solution.y0(1)))+A(M(1),2);
z01 = real(double(solution.z0(1)))+A(M(1),3);

try
    x02 = real(double(solution.x0(2))+A(M(1),1));
    y02 = real(double(solution.y0(2))+A(M(1),2));
    z02 = real(double(solution.z0(2))+A(M(1),3));
catch
    x02 = -10000;
    y02 = -10000;
    z02 = -10000;
end























%Initialize symbolic variables
%syms x0
%syms y0
%syms z0

%syms t1_2
%syms t1_3
%syms t1_4
%syms t2_3
%syms t2_4
%syms t3_4

%Define equations of TGF location
%equ1_2 = sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) == c*t1_2;
%equ1_3 = sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) == c*t1_3;
%equ1_4 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) == c*t1_4;

%equ1_2 = sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) == c*t1_2;
%equ1_3_1 = sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) - c*t1_3 == 0;
%equ1_3_2 = sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) - c*t1_3 == 0;
%equ1_4_1 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) - c*t1_4 == 0;
%equ1_4_2 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt(x0.^2+y0.^2+z0.^2) - c*t1_4 == 0;
%equ2_3_1 = sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2)-sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2) - c*(t2_3) == 0;
%equ2_3_2 = t1_3-t1_2==t2_3;
%equ2_3_2 = sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2)-sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2) - c*t2_3 > -0.0001;
%equ2_4_1 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2) - c*t2_4 < 0.0001;
%equ2_4_2 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt((x2-x0).^2+(y2-y0).^2+(z2-z0).^2) - c*t2_4 > -0.0001;
%equ3_4_1 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2) - c*t3_4 < 0.0001;
%equ3_4_2 = sqrt((x4-x0).^2+(y4-y0).^2+(z4-z0).^2)-sqrt((x3-x0).^2+(y3-y0).^2+(z3-z0).^2) - c*t3_4 > -0.0001;
%Solve equations; Result in terms of t2,t3,t4; Two possible solutions
%solution=solve(equ1_2,equ1_3_1,equ1_3_2,equ1_4_1,equ1_4_2,equ2_3_1,x0,y0,z0)


%pause
%Substitute in times and convert to doubles
%x01 = real(double(subs(subs(subs(solution.x0(1,1),t2,T(2)-T(1)),t3,T(3)-T(1)),t4,T(4)-T(1)))+A(M(1),1));
%x02 = real(double(subs(subs(subs(solution.x0(2,1),t2,T(2)-T(1)),t3,T(3)-T(1)),t4,T(4)-T(1)))+A(M(1),1));
%y01 = real(double(subs(subs(subs(solution.y0(1,1),t2,T(2)-T(1)),t3,T(3)-T(1)),t4,T(4)-T(1)))+A(M(1),2));
%y02 = real(double(subs(subs(subs(solution.y0(2,1),t2,T(2)-T(1)),t3,T(3)-T(1)),t4,T(4)-T(1)))+A(M(1),2));
%z01 = real(double(subs(subs(subs(solution.z0(1,1),t2,T(2)-T(1)),t3,T(3)-T(1)),t4,T(4)-T(1)))+A(M(1),3));
%z02 = real(double(subs(subs(subs(solution.z0(2,1),t2,T(2)-T(1)),t3,T(3)-T(1)),t4,T(4)-T(1)))+A(M(1),3));

diff01 = sqrt((x01-tgf(1,1))^2+(y01-tgf(1,2))^2+(z01-tgf(1,3))^2);
diff02 = sqrt((x02-tgf(1,1))^2+(y02-tgf(1,2))^2+(z02-tgf(1,3))^2);

if(diff01<diff02)
    x = x01;
    y = y01;
    z = z01;
    xp = x02;
    yp = y02;
    zp = z02;
else
    x = x02;
    y = y02;
    z = z02;
    xp = x01;
    yp = y01;
    zp = z01;
end


%{
% Calculate the distance from each of the payloads to each of the solutions
diff1_01 = sqrt((x01-A(M(1),1))^2+(y01-A(M(1),2))^2+(z01-A(M(1),3))^2);
diff1_02 = sqrt((x02-A(M(1),1))^2+(y02-A(M(1),2))^2+(z02-A(M(1),3))^2);
diff2_01 = sqrt((x01-A(M(2),1))^2+(y01-A(M(2),2))^2+(z01-A(M(2),3))^2);
diff2_02 = sqrt((x02-A(M(2),1))^2+(y02-A(M(2),2))^2+(z02-A(M(2),3))^2);
diff3_01 = sqrt((x01-A(M(3),1))^2+(y01-A(M(3),2))^2+(z01-A(M(3),3))^2);
diff3_02 = sqrt((x02-A(M(3),1))^2+(y02-A(M(3),2))^2+(z02-A(M(3),3))^2);
diff4_01 = sqrt((x01-A(M(4),1))^2+(y01-A(M(4),2))^2+(z01-A(M(4),3))^2);
diff4_02 = sqrt((x02-A(M(4),1))^2+(y02-A(M(4),2))^2+(z02-A(M(4),3))^2);


%Check which of the solutions hits the payloads in the correct order
if(((diff1_01<=diff2_01 && diff2_01<=diff3_01 && diff3_01<=diff4_01) && ~(diff1_02<=diff2_02 && diff2_02<=diff3_02 && diff3_02<=diff4_02)) || z02<0)
    x=x01;
    y=y01;
    z=z01;
    xp=0;
    yp=0;
    zp=0;
    %fprintf('X=%.8f Y=%.8f Z=%.8f\n',x,y,z);
elseif(((diff1_02<=diff2_02 && diff2_02<=diff3_02 && diff3_02<=diff4_02) && ~(diff1_01<=diff2_01 && diff2_01<=diff3_01 && diff3_01<=diff4_01)) || z01<0)
    x=x02;
    y=y02;
    z=z02;
    xp=0;
    yp=0;
    zp=0;
    %fprintf('X=%.8f Y=%.8f Z=%.8f\n',x,y,z);
elseif((diff1_02<=diff2_02 && diff2_02<=diff3_02 && diff3_02<=diff4_02) && (diff1_01<=diff2_01 && diff2_01<=diff3_01 && diff3_01<=diff4_01))
    disp("Two Solutions!!!!!")
    
    if(diff1_01<diff1_02)
        x=x01;
        y=y01;
        z=z01;
        xp=x02;
        yp=y02;
        zp=z02;
    else
        x=x02;
        y=y02;
        z=z02;
        xp=x01;
        yp=y01;
        zp=z01;
    end

else
    x=0;
    y=0;
    z=0;
    xp=0;
    yp=0;
    zp=0;
    disp("No Good Solution!!!!")
end
%}




