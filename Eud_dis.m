function [ Dis ] = Eud_dis(x1,y1,x2,y2 )
% This function calculates the euclidean distance between (x1,y1) and
% (x2,y2).
Dis=((x1-x2)^2) + ((y1-y2)^2);
Dis=Dis^.5;

end

