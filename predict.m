%在线选择r和n
function [r,n]=predict(Pr,N)
Pr=Pr*100;
if Pr>=55
    i=1;
elseif (45<=Pr)&&(Pr<55)
    i=2;
elseif (35<=Pr)&&(Pr<45)
    i=3;
elseif (25<=Pr)&&(Pr<35)
    i=4;
elseif (15<=Pr)&&(Pr<25)
    i=5;
elseif (5<=Pr)&&(Pr<15)
    i=6;
else
    i=7;
end
switch i
    case 1
        r=4;
        n=round(0.18*N);
    case 2
        r=8;
        n=round(0.13*N);
    case 3
        r=12;
        n=round(0.09*N);
    case 4
        r=16;
        n=round(0.06*N);
    case 5
        r=20;
        n=round(0.05*N);
    case 6
        r=25;
        n=round(0.04*N);
    otherwise
        r=34;
        n=round(0.03*N);
end
end