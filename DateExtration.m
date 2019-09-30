% license plate recognition - car plate location based on color model
% modified by KouLiangzhi, Oct 10th,2007
I=imread('Car.jpg');
[y,x,z]=size(I);
myI=double(I);

%%%%%%%%%%% 统计分析 %%%%%%%%%%%%%%%
%%%%%%%% Y 方向 %%%%%%%%%%
Blue_y=zeros(y,1);
for i=1:y
    for j=1:x
            if((myI(i,j,1)<=121)&&myI(i,j,1)>=110&&((myI(i,j,2)<=155)&&(myI(i,j,2)>=141))&&((myI(i,j,3)<=240)&&(myI(i,j,3)>=210))) 
% 蓝色RGB的灰度范围
               Blue_y(i,1)= Blue_y(i,1)+1;     % 蓝色象素点统计          
           end  
    end       
end
[temp MaxY]=max(Blue_y);        % Y方向车牌区域确定
PY1=MaxY;
while ((Blue_y(PY1,1)>=5)&&(PY1>1))
       PY1=PY1-1;
end    
PY2=MaxY;
while ((Blue_y(PY2,1)>=5)&&(PY2<y))
       PY2=PY2+1;
end
IY=I(PY1:PY2,:,:);

%%%%%%%% X 方向 %%%%%%%%%% 
Blue_x=zeros(1,x);             % 进一步确定X方向的车牌区域
for j=1:x
    for i=PY1:PY2
            if((myI(i,j,1)<=121)&&myI(i,j,1)>=110&&((myI(i,j,2)<=155)&&(myI(i,j,2)>=141))&&((myI(i,j,3)<=240)&&(myI(i,j,3)>=210))) 
               Blue_x(1,j)= Blue_x(1,j)+1;               
           end  
    end       
end

PX1=1;
while ((Blue_x(1,PX1)<3)&&(PX1<x))
       PX1=PX1+1;
end    
PX2=x;
while ((Blue_x(1,PX2)<3)&&(PX2>PX1))
       PX2=PX2-1;
end
PX1=PX1+17;
PX2=PX2-1;
PY1=PY1+5;
PY2=PY2-2; % 对车牌区域的修正

Plate=I(PY1:PY2,PX1:PX2,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,imshow(Plate);
m=PX2-PX1;
n=PY2-PY1;
S=ones(n,m);
for j=1:m
    for i=1:n
            if((Plate(i,j,1)<=121)&&Plate(i,j,1)>=110&&((Plate(i,j,2)<=155)&&(Plate(i,j,2)>=141))&&((Plate(i,j,3)<=240)&&(Plate(i,j,3)>=210))) 
               S(i,j)=0;        
           end  
    end       
end