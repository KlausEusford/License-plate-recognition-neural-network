%【步骤一、样本输入】
%------------样本的维数和个数，例如：每个样本的维数为35，每种模式的训练样本个数为10，则输入的训练样本矩阵应该为：p＝[模式1 模式2 … 模式n]，模式1～模式n为35×10的样本矩阵。
%  例如：对于如下的黑白字符“A”（其表示点阵为7×5），若□表示0，■表示1。则其表示的特征数据为：00100010100101010001111111000110001，这个样本的数据长度为35。
%      □□■□□
%      □■□■□
%      □■□■□
%      ■□□□■
%      ■■■■■
%      ■□□□■
%      ■□□□■
%按照上述类似的步骤可以依次得到：B～Z的特征数据。注意：每种字符只有一个训练样本，如果还有其他的训练样本，则依次添加到对应的特征矩阵内即可：
nntwarn off;
A=[0 0 1 0 0 0 1 0 1 0 0 1 0 1 0 1 0 0 0 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 1]';
B=[1 1 1 1 0 1 0 0 0 1 1 0 0 0 1 1 1 1 1 0 1 0 0 0 1 1 0 0 0 1 1 1 1 1 0]';
C=[0 1 1 1 0 1 0 0 0 1 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 1 0]';
D=[1 1 1 1 0 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 1 1 1 0]';
E=[1 1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 1 1 1 0 1 0 0 0 0 1 0 0 0 0 1 1 1 1 1]';
F=[1 1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 1 1 1 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0]';
zer=[1 1 1 1 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 1 1 1 1]';
one=[0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0]';
two=[1 1 1 1 1 0 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 0 1 1 1 1 1]';
thr=[1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 1 1 1 1 1]';
fou=[1 0 1 0 0 1 0 1 0 0 1 0 1 0 0 1 1 1 1 1 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0]';
fiv=[1 1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 1 1 1 1 1]';
six=[1 1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 1 1 1 1 1 0 0 0 1 1 0 0 0 1 1 1 1 1 1]';
sev=[1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1]';
eig=[1 1 1 1 1 1 0 0 0 1 1 0 0 0 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 1 1 1 1 1 1]';
nin=[1 1 1 1 1 1 0 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 1 1 1 1 1]';
% 则对训练样本的矩阵初始化如下：
alphabet=[A,B,C,D,E,F,zer,one,two,thr,fou,fiv,six,sev,eig,nin];
p=alphabet;
targets=eye(16,16);
t=targets;
%------------样本的输出值，即输出目标矢量，希望在每一种模式输入时，在输出的位置上输出为1，其他的位置应该为0。若共有模式为16种
%------------每种模式的样本训练为1个，则输出矢量可以简单表示为： targets＝eye(16,16)
%----------------确定网络的输入、隐层和输出层
[r,q]=size(p);   %输入
[s2,q]=size(t);  %输出
s1=13;           %隐层神经元的数目，可以根据实际需要选择，一般其数目不能超过训练样本的个数。
%-----------------确定网络训练的初值
[w1,b1]=nwlog(s1,r);
[w2,b2]=rands(s2,s1);


%  【步骤二、设置网络参数并训练】
%----------------确定网络训练的参数
disp_freq=50;    %网络训练的显示频率
max_epoch=5000;  %最大训练次数
err_goal=0.01;   %训练的误差
lr=0.1;         %学习率大小
lr_inc=1.05;     %增量
lr_dec=0.5;      %减量
momentum=0.75;   %动量因子
err_ratio=1.05;  %误差率

%-------------训练开始
tp=[disp_freq max_epoch err_goal lr lr_inc lr_dec momentum err_ratio]';
[w1,b1,w2,b2,epochs,TR]=trainbpx(w1,b1,'logsig',w2,b2,'logsig',p,t,tp);
save digit.mat w1 b1 w2 b2;    %--------存储权值，以方便测试


%【步骤三、测试】
%---------------测试，输入的测试样本为p
load digit_noise.mat
layer1=logsig(w1*p,b1);
a=logsig(w2*layer1,b2);
%-----------------根据a中的最大值可以判断属于何种故障模式
save digit_nois_result.mat a; %--------存储测试结果