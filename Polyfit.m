%Works on MatlabR2018b/trial use
clear all
close all
clc
 %generate data
fileID = fopen('data25.txt','r');
A = fscanf(fileID,'%f %f',[2 Inf]);
%insert kedalam matrix
x = A(1,:);
y = A(2,:);

dimensi = 0;
n = length(x);
fold = 5;

%Mengacak urutan 
index = 1:50;
index = index(randperm(length(index)));
x = x(index);
y = y(index);

sr = 0;
sr_min = realmax;
pangkat_terbaik = 0;
for pangkat=1:5
    for i=1:fold
        id_batas_bawah = (i-1)*(n/fold) + 1;
        id_batas_atas = (i)*(n/fold);
        x_train= x([1:id_batas_bawah id_batas_atas:n]); 
        x_test = x(id_batas_bawah:id_batas_atas);
        y_train= y([1:id_batas_bawah id_batas_atas:n]);
        y_test = y(id_batas_bawah:id_batas_atas);
        reg = fPolyFit(x_train,y_train,pangkat);
        ypred = polyval(reg,x_test);
        sr = sr + sqrt(sum((y_test-ypred).^2)/(n-pangkat-1));
        
    end
        sr = sr/fold;
        if (sr<sr_min)
            sr_min = sr;
            pangkat_terbaik = pangkat;
        end
        sr = 0;
end
fprintf("dimensi terbaik adalah dimensi drajat");
disp(pangkat_terbaik);
fprintf("dengan nilai sr terendah :");
disp(sr_min);

xgambar = min(x):0.1:max(x);
reg_terbaik = fPolyFit(x,y,pangkat_terbaik);
ygambar = polyval(reg_terbaik,xgambar);
plot(x,y,'.',xgambar,ygambar)

function p = fPolyFit(x, y, n)
    X = ones(length(x),n+1);
    X(:,2) = x;
    for i=3:n+1
        X(:,i) = X(:,2).^(i-1);
    end
    X = fliplr(X);
    p = inv(X'*X)*X'*y';
end